require_relative '../delete'

module Sqlbuilder
  module Statements
    module Postgres
      class Delete < Statements::Delete
        def format_single_value(value)
          "'#{value}'"
        end
      end
    end
  end
end
