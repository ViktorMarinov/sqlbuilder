module Sqlbuilder
	module Dialects
		class Default
			class SelectBuilder
				def from(table_name)
					"FROM #{table_name}"
				end

				def where(query_hash)
					where_clause = query_hash.map { |key, value| "#{key} = #{value}" }.join(' AND ')

					"WHERE #{where_clause}"
				end

				def order(order_hash)
					order_by_clause = order_hash.map { |key, order| "#{key} #{order}" }.join(', ')

					"ORDER BY #{order_by_clause}"
				end

				def limit(limit)
					"LIMIT #{limit}"
				end

				def offset(offset)
					"OFFSET #{offset}"
				end
			end
		end
	end
end