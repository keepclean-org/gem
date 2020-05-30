require_relative 'base'
require 'erb_lint/cli'

module Integration
  class ErbLint < Base
    def run_with(config)
      args = ['--lint-all']
      Keepclean.logger.debug "Running with args: #{args}"
      ERBLint::CLI.new.run(args)
    end
  end
end
