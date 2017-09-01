module Sqlbuilder
  module Statements
    module Builders
      module InsertBuilder
        def build_into
          "INTO #{@table}"
        end

        def build_columns
          columns_str = @columns.map(&:to_s).join(", ")

          "(#{columns_str})"
        end

        def build_values
          values_str = @values_list
            .map {|values| values.map {|value| @utils.format_value(value) }.join(", ") }
            .map {|values| "(#{values})" }
            .join(", ")

          "VALUES #{values_str}"
        end
      end
    end
  end
end
