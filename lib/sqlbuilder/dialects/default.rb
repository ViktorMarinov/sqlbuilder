require_relative "default/select_builder"
require_relative "default/insert_builder"

module Sqlbuilder
	module Dialects
		class Default
			def select_builder
				SelectBuilder.new
			end

      def insert_builder
        InsertBuilder.new
      end
		end
	end
end
