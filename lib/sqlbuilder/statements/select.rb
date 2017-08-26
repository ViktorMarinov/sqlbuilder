require_relative '../generators/select_generator'

module Sqlbuilder
	module Statements
		class Select
			include Generators::SelectGenerator

			def initialize
				@columns = []
			end

			def columns(columns)
				@columns = columns
			end

			def column(column)
				@columns << column
			end

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
				sql = "SELECT"
				sql << " #{build_columns(@columns)}"
				sql << " #{build_from(@table_name)}"
				sql << " #{build_where(@where)}" if @where
				sql << " #{build_order(@order)}" if @order
				sql << " #{build_limit(@limit)}" if @limit
				sql << " #{build_offset(@offset)}" if @offset

				sql
			end
		end
	end
end
