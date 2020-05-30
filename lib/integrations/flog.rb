require_relative 'base'
require "flog_cli"

module Integration
  class Flog < Base
    def run_with(config)
      args = ['-m']
      Keepclean.logger.debug "Running with args:  #{args.inspect}"
      FlogCLI.run(args)
      true
    end
  end
end
