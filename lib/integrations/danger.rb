require_relative 'base'
require 'danger'

module Integration
  class Danger < Base
    def run_with(config)
      args = ['staging']
      Keepclean.logger.debug "Running with args: #{args}"
      ::Danger::Runner.run args
    end
  end
end
