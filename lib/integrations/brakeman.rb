require_relative 'base'
require 'brakeman'
require 'brakeman/commandline'

module Integration
  class Brakeman < Base
    def run_with(config)
      args = {
        quiet: true,
        summary_only: :no_summary,
      }
      Keepclean.logger.debug "Running with args: #{args.inspect}"
      ::Brakeman::Commandline.start(args)
      true
    end
  end
end
