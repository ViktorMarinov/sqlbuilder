module Sqlbuilder
  module Generators
    module InsertGenerator
      def build_into
        "INTO #{@table}"
      end

      def build_columns
        columns_str = @columns.map(&:to_s).join(", ")

        "(#{columns_str})"
      end

      def build_values
        values_str = @values_list
                     .map {|values| values.map {|value| format_single_value(value) }.join(", ") }
                     .map {|values| "(#{values})" }
                     .join(", ")

        "VALUES #{values_str}"
      end

      def format_single_value(value)
        value.to_s
      end
    end
  end
end
