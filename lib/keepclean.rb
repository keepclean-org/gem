require 'net/http'
require 'json'
require 'active_support/core_ext/string/inflections.rb'

require 'keepclean/version'
require 'keepclean/formatter'

module Keepclean
  def self.project_name
    ENV['KEEPCLEAN_PROJECT'] || ENV['DRONE_REPO']
  end

  def self.build_id
    ENV['KEEPCLEAN_BUILD_ID'] || ENV['DRONE_BUILD_NUMBER']
  end

  def self.logger
    return @logger if defined?(@logger)
    @log_output = StringIO.new
    @logger = ActiveSupport::TaggedLogging.new(Logger.new(@log_output)).tap do |l|
      l.level = if ENV['KEEPCLEAN_DEBUG']
        Logger::DEBUG
      else
        Logger::WARN
      end
      l.formatter = Formatter.new
    end
  end

  def self.run(args)
    at_exit do
      logs = @log_output.string
      unless logs.empty?
        puts ""
        puts "===== DEBUG ====="
        puts ""
        puts logs
      end
    end

    puts "*** Keepclean v#{Keepclean::VERSION} ***"

    token = ENV['KEEPCLEAN_TOKEN']
    unless token
      puts "Token no set, use KEEPCLEAN_TOKEN"
      exit -1
    end

    unless project_name
      puts "Project no set, use KEEPCLEAN_PROJECT"
      exit -1
    end

    uri = URI('http://192.168.0.31:5000/manifest')
    res = Net::HTTP.post_form(uri, {
      version: Keepclean::VERSION,
      token: token,
      project: project_name
    })

    unless res['content-type'].start_with?('application/json')
      puts res.body
      exit -1
    end

    manifest = JSON.parse(res.body)
    logger.debug "Manifest: #{manifest}"

    puts "Configure at: #{manifest['configuration_url']}"

    success = true

    manifest.each do |key, metadata|
      next unless metadata['enabled']

      klass = case key
      when 'custom'
       class_name =  metadata.dig('config', 'class_name')
       unless class_name
         puts "#{key} check skipped because the class_name is not configured"
         next
       end
       class_name.gsub('Integration::', '')
      else
        key.camelize
      end

      logger.tagged(klass) do
        begin
          puts ""
          puts "*** #{klass} ***"
          puts ""

          require "integrations/#{klass.underscore}"
          success &= "Integration::#{klass}".constantize.new(pronto: metadata['on_branch']).run_with_config_handling_exit(metadata['config']) || metadata['allowed_to_fail']
          logger.debug "Success: #{success}"
        rescue LoadError => e
          puts "#{klass} check skipped because of error: #{e.message}"
        ensure
          if klass
            puts ""
            puts "*** /#{klass}/ ***"
            puts ""
          end
        end
      end
    end

    exit success
  rescue Errno::ECONNREFUSED => e
    puts "We couldn't reach the keepclean server: #{e.message}"
  end
end
