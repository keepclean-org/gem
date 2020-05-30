require_relative 'base'
require 'license_finder'

module Integration
  class LicenseFinder < Base
    def run_with(config)
      Tempfile.create(['dependency_decisions', '.yml']) do |f|
        dependency_decisions = []

        allowed_licenses = config.fetch('allowed_licenses', [])

        allowed_licenses.each do |allowed_license|
          dependency_decisions << [:permit, allowed_license, { who: 'Keepclean' }]
        end

        f.write dependency_decisions.to_yaml
        f.close

        args = ['--decisions_file', f.path]
        Keepclean.logger.debug "Running with args: #{args.inspect}"
        ::LicenseFinder::CLI::Main.start(args)
      end

      true
    end
  end
end
