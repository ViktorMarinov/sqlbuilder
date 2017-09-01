module Sqlbuilder
  module Utils
    class Postgres
      def format_value(value)
        "'#{value}'"
      end
    end
  end
end
