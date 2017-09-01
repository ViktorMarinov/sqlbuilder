require_relative "select_builder"

module Sqlbuilder
  module Statements
    module Builders
      module DeleteBuilder
        include SelectBuilder
      end
    end
  end
end
