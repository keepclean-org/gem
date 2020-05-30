require_relative 'base'
require 'rubocop'

module Integration
  class Rubocop < Base
    def run_with(config)
      Keepclean.logger.debug "Running with args:"
      RuboCop::CLI.new.run == 0
    end
  end
end
