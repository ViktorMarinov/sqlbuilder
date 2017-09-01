require "pg"

require_relative "default"

module Sqlbuilder
  module Utils
    class Postgres < Default
      def format_value(value)
        PG::Connection.quote_connstr(value)
      end

      def format_column(column)
        if column == "*"
          "*"
        else
          "\"#{column}\""
        end
      end

      def escape_value(value)
        if value.is_a? String
          PG::Connection.escape_string(value)
        else
          value
        end
      end
    end
  end
end
