require_relative 'default'

module Sqlbuilder
  module Utils
    class Postgres < Default
      def format_value(value)
        "'#{value}'"
      end

      def format_column(column)
        "\"#{column}\""
      end

      def escape_string(string)
        string.replace("'", "''")
      end
    end
  end
end
