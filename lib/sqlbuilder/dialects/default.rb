require_relative "default/select_builder"

module Sqlbuilder
	module Dialects
		class Default
			def select_builder
				SelectBuilder.new
			end
		end
	end
end