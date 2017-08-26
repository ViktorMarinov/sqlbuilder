module Sqlbuilder
  module Generators
    module UpdateGenerator
      def build_where(query_hash)
        where_clause = query_hash.map do |key, value|
          "#{key} = #{format_single_value(value)}"
        end

        "WHERE #{where_clause.join(" AND ")}"
      end

      def build_set(set_hash)
        set_list = set_hash.map do |key, value|
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
