module Sqlbuilder
  module Statements
    module Builders
      module SelectBuilder
        def build_columns
          if @columns.empty?
            "#{prefix}*"
          else
            @columns.map {|col| build_column(col)}.join(", ")
          end
        end

        def build_from
          from = "FROM #{@table}"
          if @aliaz
            from << " #{@aliaz}"
          end

          from
        end

        def build_joins
          join_lines = @joins.map do |join|
            from = join[:from]
            type = join[:type]
            aliaz = join[:aliaz]

            table1_alias = if @aliaz then "#{@aliaz}" else "#{@table}" end
            table2_alias = if aliaz then "#{aliaz}" else "#{from}" end

            on = join[:on]
              .map do |col1, col2|
                [@utils.format_column(col1), @utils.format_column(col2)]
              end
              .map do |table1_col, table2_col|
                "#{table1_alias}.#{table1_col} = #{table2_alias}.#{table2_col}"
              end

            join_statement = "#{type} JOIN #{from}"

            if aliaz
              join_statement << " #{aliaz}"
            end

            unless on.empty?
              join_statement << " ON #{on.join(' AND ')}"
            end

            join_statement
          end

          join_lines.join(' ')
        end

        def build_where
          where_clause = @where.map do |key, value|
            if value.is_a?(String) &&
               [">", "<", "!=", ">=", "<="].any? {|comp| value.include? comp }

              # TODO: raise custom exception if has more values after split
              symbol, extracted_value = value.split(" ")
              "#{prefix}#{@utils.format_column(key)} #{symbol} "\
              "#{format_value(extracted_value)}"
            else
              "#{prefix}#{@utils.format_column(key)} = #{format_value(value)}"
            end
          end

          "WHERE #{where_clause.join(" AND ")}"
        end

        def build_order
          order_by_clause = @order.map do |key, order|
            "#{prefix}#{@utils.format_column(key)} #{order}"
          end

          "ORDER BY #{order_by_clause.join(", ")}"
        end

        def build_limit
          "LIMIT #{@limit}"
        end

        def build_offset
          "OFFSET #{@offset}"
        end

        private

        def format_value(value)
          escaped = @utils.escape_value(value)
          @utils.format_value(escaped)
        end

        def build_column(column)
          col = @utils.format_column(column[:col])

          if column[:aggregation]
            return "#{column[:aggregation]}(#{col})"
          end

          if column[:from]
            col = "#{column[:from]}.#{col}"
          end

          if column[:as]
            "#{col} AS #{@utils.format_column(column[:as])}"
          else
            col
          end
        end

        def prefix
          if @aliaz
            "#{@aliaz}."
          else
            ""
          end
        end
      end
    end
  end
end
