require_relative "../select"

module Sqlbuilder
  module Statements
    module Postgres
      class Select < Statements::Select
        def format_single_value(value)
          "'#{value}'"
        end
      end
    end
  end
end
