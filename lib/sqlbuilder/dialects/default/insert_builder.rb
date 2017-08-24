module Sqlbuilder
  module Dialects
    class Default
      class InsertBuilder
        def into(table)
          "INTO #{table}"
        end

        def columns(columns)
          columns_str = columns.map(&:to_s).join(', ')

          "(#{columns_str})"
        end

        def values(values_array)
          values_str = values_array
            .map { |values| values.map { |value| "'#{value}'" }.join(', ') }
            .map { |values| "(#{values})" }
            .join(', ')

          "VALUES #{values_str}"
        end
      end
    end
  end
end
