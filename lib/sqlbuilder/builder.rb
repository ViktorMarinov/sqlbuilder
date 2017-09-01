require_relative "statements/select"
require_relative "statements/insert"
require_relative "statements/update"
require_relative "statements/delete"
require_relative "utils/default"

module Sqlbuilder
  class Builder

    def initialize
      @utils = Utils::Default.new
    end

    def select
      Statements::Select.new(@utils)
    end

    def insert
      Statements::Insert.new(@utils)
    end

    def update
      Statements::Update.new(@utils)
    end

    def delete
      Statements::Delete.new(@utils)
    end
  end
end
