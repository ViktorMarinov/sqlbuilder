module Sqlbuilder
  module Utils
    class Default
      def format_value(value)
        value.to_s
      end

      def format_column(column)
        "#{column}"
      end

      def escape_string(string)
        string.replace("'", "''")
      end

      def escape_id_string(id_string)

      end

      def escape_value(value)

      end
    end
  end
end
