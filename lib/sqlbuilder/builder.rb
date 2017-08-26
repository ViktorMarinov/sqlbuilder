require_relative 'statements/select'
require_relative 'statements/insert'
require_relative 'statements/update'
require_relative 'statements/delete'

module Sqlbuilder
	class Builder
 		def select
			Statements::Select.new
		end

    def insert
      Statements::Insert.new
    end

    def update
      Statements::Update.new
    end

    def delete
      Statements::Delete.new
    end
	end
end
