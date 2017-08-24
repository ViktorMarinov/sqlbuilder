require "sqlbuilder/version"

require_relative "statements/select"
require_relative "statements/insert"

module Sqlbuilder
	class Builder

		def initialize(dialect)
			@dialect = dialect
		end

 		def select
			Statements::Select.new(@dialect.select_builder)
		end

    def insert
      Statements::Insert.new(@dialect.insert_builder)
    end
	end
end
