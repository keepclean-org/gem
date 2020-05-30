require_relative 'base'
require 'bundler/audit/cli'

module Integration
  class BundleAudit < Base
    def run_with(config)
      args = ['check']

      ignored_cves = config.fetch('ignored_cve', [])

      if !ignored_cves.empty?
        args += ["--ignore"]
        ignored_cves.each do |ignored_cve|
          args << ignored_cve
        end
      end

      Keepclean.logger.debug "Updating CVE database"
      Bundler::Audit::CLI.start(['update', '--quiet'])

      Keepclean.logger.debug "Running with args: #{args.inspect}"
      Bundler::Audit::CLI.start(args)
      true
    end
  end
end
