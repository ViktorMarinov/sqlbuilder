module Sqlbuilder
  module Utils
    class Default
      def format_value(value)
        value.to_s
      end

      def format_column(column)
        column.to_s
      end

      def escape_value(value)
        value
      end
    end
  end
end
