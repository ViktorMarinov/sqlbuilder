require_relative '../insert'

module Sqlbuilder
  module Statements
    module Postgres
      class Insert < Statements::Insert
        def on_conflict(columns)

        end

        def update

        end

        def format_single_value(value)
          "'#{value}'"
        end
      end
    end
  end
end
