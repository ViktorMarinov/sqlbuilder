require_relative "default/select_builder"
require_relative "default/insert_builder"
require_relative "default/update_builder"
require_relative "default/delete_builder"

module Sqlbuilder
	module Dialects
		class Default
			def select_builder
				SelectBuilder.new
			end

      def insert_builder
        InsertBuilder.new
      end

      def update_builder
        UpdateBuilder.new
      end

      def delete_builder
        DeleteBuilder.new
      end
		end
	end
end
