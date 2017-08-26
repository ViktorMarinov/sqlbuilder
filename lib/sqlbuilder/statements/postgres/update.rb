require_relative "../update"

module Sqlbuilder
  module Statements
    module Postgres
      class Update < Statements::Update
        def format_single_value(value)
          "'#{value}'"
        end
      end
    end
  end
end
