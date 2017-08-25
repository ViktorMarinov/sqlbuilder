module Sqlbuilder
	module Dialects
		class Default
			class SelectBuilder
				def columns(columns)
					if columns.empty?
						"*"
					else
						columns.map(&:to_s).join(', ')
					end
				end

				def from(table_name)
					"FROM #{table_name}"
				end

				def where(query_hash)
					where_clause = query_hash.map do |key, value|
						if value.is_a?(String) &&
							 ['>', '<', '!='].any? { |comp| value.include? comp }

							#TODO: raise custom exception if has more values after split
							symbol, extracted_value = value.split(' ')
							"#{key} #{symbol} '#{extracted_value}'"
						else
							"#{key} = '#{value}'"
						end
					end.join(' AND ')

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
