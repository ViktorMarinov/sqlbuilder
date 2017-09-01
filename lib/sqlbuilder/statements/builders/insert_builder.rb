module Sqlbuilder
  module Statements
    module Builders
      module InsertBuilder
        def build_into
          "INTO #{@table}"
        end

        def build_columns
          columns_str = @columns.map { |col| @utils.format_column(col) }

          "(#{columns_str.join(", ")})"
        end

        def build_values
          values_str = @values_list
            .map do |values|
              values.map do |value|
                @utils.format_value(@utils.escape_value(value))
              end.join(", ")
            end
            .map {|values| "(#{values})" }
            .join(", ")

          "VALUES #{values_str}"
        end
      end
    end
  end
end
