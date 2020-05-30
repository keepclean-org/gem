require_relative 'base'
require 'rails_best_practices'

module Integration
  class RailsBestPractices < Base
    def run_with(config)
      args = ['.', { 'silent' => true }]
      Keepclean.logger.debug "Running with args: #{args.inspect}"
      analyzer = ::RailsBestPractices::Analyzer.new(*args)
      analyzer.analyze
      analyzer.output
      analyzer.runner.errors.empty?
    end
  end
end
