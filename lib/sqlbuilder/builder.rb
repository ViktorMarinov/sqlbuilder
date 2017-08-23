require "sqlbuilder/version"

require_relative "statements/select"

module Sqlbuilder
	class Builder

		def initialize(dialect)
			@dialect = dialect
		end

 		def select
			Statements::Select.new(@dialect.select_builder)
		end
	end
end
