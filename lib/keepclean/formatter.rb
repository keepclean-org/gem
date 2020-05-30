require 'logger'
require 'active_support/tagged_logging.rb'

module Keepclean
  class Formatter < Logger::Formatter
    include ActiveSupport::TaggedLogging::Formatter

    def call(severity, timestamp, progname, msg)
      (String === msg ? msg : msg.inspect).split("\n").map do |line|
        "%s %s[%s] %s%s: %s\n" % [Time.at(timestamp).strftime("%b %e %H:%M:%S"), Keepclean.project_name, Keepclean.build_id, tags_text, severity, line]
      end.join
    end
  end
end

