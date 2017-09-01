module Sqlbuilder
  module Statements
    module Builders
      module UpdateBuilder
        def build_where
          where_clause = @where.map do |key, value|
            "#{key} = #{@utils.format_value(value)}"
          end

          "WHERE #{where_clause.join(" AND ")}"
        end

        def build_set
          set_list = @set.map do |key, value|
            "#{key} = #{@utils.format_value(value)}"
          end

          "SET #{set_list.join(", ")}"
        end
      end
    end
  end
end
