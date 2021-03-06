begin
  require 'em-hiredis'
rescue LoadError => error
  raise 'Missing EM-Synchrony dependency: gem install em-hiredis'
end

module EventMachine
  module Hiredis
    class Client

      def self.connect(host = 'localhost', port = 6379)
        conn = new(host, port)
        EM::Synchrony.sync conn.connect
        conn
      end

      alias :old_method_missing :method_missing
      def method_missing(sym, *args)
        EM::Synchrony.sync old_method_missing(sym, *args)
      end
    end
  end
end
