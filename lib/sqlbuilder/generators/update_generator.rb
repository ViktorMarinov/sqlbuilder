module Sqlbuilder
  module Generators
    module UpdateGenerator
      def build_where(query_hash)
        where_clause = query_hash.map do |key, value|
          "#{key} = #{format_single_value(value)}"
        end.join(' AND ')

        "WHERE #{where_clause}"
      end

      def build_set(set_hash)
        set_list = set_hash.map do |key, value|
          "#{key} = #{format_single_value(value)}"
        end.join(', ')

        "SET #{set_list}"
      end

      def format_single_value(value)
        value.to_s
      end
    end
  end
end
