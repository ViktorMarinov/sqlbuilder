module Sqlbuilder
	module Statements
		class Select

			def initialize(select_builder)
				@select_builder = select_builder
			end

			"""Builder methods"""

			def from(table_name)
				@table_name = table_name

				self
			end

			def where(query_hash)
				@where = query_hash

				self
			end

			def order(order_hash)
				@order = order_hash

				self
			end

			def limit(limit)
				@limit = limit

				self
			end

			def offset(offset)
				@offset = offset

				self
			end

			def build
				sql = "SELECT *"
				sql << " #{@select_builder.from(@table_name)}"
				sql << " #{@select_builder.where(@where)}" if @where
				sql << " #{@select_builder.order(@order)}" if @order
				sql << " #{@select_builder.limit(@limit)}" if @limit
				sql << " #{@select_builder.offset(@offset)}" if @offset
				
				sql
			end
		end
	end
end