require_relative 'base'
require 'flay'

module Integration
  class Flay < Base
    def run_with(config)
      args = []

      if mass_threshold = config['mass_threshold']
        args += ['-m', mass_threshold.to_s]
      end

      should_delete_flayignore = false
      if ignored = config['ignored']
        if File.file?('.flayignore')
          Keepclean.logger.warn('Using local .flayignore')
        else
          should_delete_flayignore = File.write('.flayignore', ignored.join("\n"), mode: 'a') != 0
        end
      end

      args += ['-d', '-#']

      Keepclean.logger.debug "Running with args: #{args.inspect}"
      flay = ::Flay.run(args)
      flay.report

      File.delete('.flayignore') if should_delete_flayignore

      flay.total == 0
    end
  end
end
