module Sqlbuilder
  module Generators
    module UpdateGenerator
      def build_where
        where_clause = @where.map do |key, value|
          "#{key} = #{format_single_value(value)}"
        end

        "WHERE #{where_clause.join(" AND ")}"
      end

      def build_set
        set_list = @set.map do |key, value|
          "#{key} = #{format_single_value(value)}"
        end

        "SET #{set_list.join(", ")}"
      end

      def format_single_value(value)
        value.to_s
      end
    end
  end
end
