require 'pronto'
require 'pronto/cli'

module Integration
  class Base
    def initialize(pronto: false)
      @pronto = pronto
    end

    def pronto_enabled?
      @pronto
    end

    def pronto_name
      self.class.name.demodulize.underscore
    end

    def run_with(config)
      raise NotImplementedError
    end

    def run_with_config_handling_exit(config)
      if pronto_enabled?
        args = ['run', '.', '--exit-code', '--runner', pronto_name]
        Keepclean.logger.debug "Running pronto with args: #{args.inspect}"
        ::Pronto::CLI.start(args)
        ::Pronto::Runner.remove_instance_variable(:@repository)
      else
        Keepclean.logger.debug "Running on all project"
        run_with(config)
      end
    rescue SystemExit => e
      Keepclean.logger.debug "Handling SystemExit: #{e.inspect} => status: #{e.status} / success?: #{e.success?}"
      return e.success?
    end
  end
end
