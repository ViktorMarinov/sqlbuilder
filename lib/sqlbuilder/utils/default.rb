module Sqlbuilder
  module Utils
    class Default
      def format_value(value)
        value.to_s
      end

      def format_column(column)
        "\"#{column}\""
      end

      # def escape_value(value)

      # end
    end
  end
end
