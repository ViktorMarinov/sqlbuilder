module Sqlbuilder
  module Dialects
    class Default
      class UpdateBuilder
        def where(query_hash)
          where_clause = query_hash.map { |key, value| "#{key} = '#{value}'" }.join(' AND ')

          "WHERE #{where_clause}"
        end

        def set(set_hash)
          set_list = set_hash.map do |key, value|
            "#{key} = '#{value}'"
          end.join(', ')

          "SET #{set_list}"
        end
      end
    end
  end
end
