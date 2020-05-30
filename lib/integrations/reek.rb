require_relative 'base'
require 'reek'
require 'reek/cli/application'

module Integration
  class Reek < Base
    def run_with(config)
      args = ['.']
      Keepclean.logger.debug "Running with args: #{args.inspect}"
      ::Reek::CLI::Application.new(args).execute == 0
    end
  end
end
