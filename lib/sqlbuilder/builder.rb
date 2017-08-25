require_relative 'statements/select'
require_relative 'statements/insert'
require_relative 'statements/update'
require_relative 'statements/delete'

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

    def update
      Statements::Update.new(@dialect.update_builder)
    end

    def delete
      Statements::Delete.new(@dialect.delete_builder)
    end
	end
end
