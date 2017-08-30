module Sqlbuilder
  module Generators
    module SelectGenerator
      def build_columns
        if @columns.empty?
          "*"
        else
          @columns.map {|col| format_single_column(col) }.join(", ")
        end
      end

      def build_from
        "FROM #{@table}"
      end

      def build_joins
        join_lines = @joins.map do |join|
          from = join[:from]
          type = join[:type]
          on = join[:on].map do |table1_col, table2_col|
            "#{@table}.#{table1_col} = #{from}.#{table2_col}"
          end

          join_statement = "#{type} JOIN #{from}"
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
            "#{key} #{symbol} #{format_single_value(extracted_value)}"
          else
            "#{key} = #{format_single_value(value)}"
          end
        end

        "WHERE #{where_clause.join(" AND ")}"
      end

      def build_order
        order_by_clause = @order.map {|key, order| "#{key} #{order}" }.join(", ")

        "ORDER BY #{order_by_clause}"
      end

      def build_limit
        "LIMIT #{@limit}"
      end

      def build_offset
        "OFFSET #{@offset}"
      end

      def format_single_column(column)
        column.to_s
      end

      def format_single_value(value)
        value.to_s
      end
    end
  end
end
