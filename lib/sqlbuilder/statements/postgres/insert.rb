require_relative "../insert"
require_relative "../../generators/postgres/insert_generator"

module Sqlbuilder
  module Statements
    module Postgres
      class Insert < Statements::Insert
        include Generators::Postgres::InsertGenerator

        def on_conflict(conflict_target)
          @on_conflict = conflict_target

          self
        end

        def update(values_to_update)
          @do_update = true
          @values_to_update = values_to_update

          self
        end

        def format_single_value(value)
          "'#{value}'"
        end

        def build
          sql = super

          if @on_conflict
            sql << " #{build_on_conflict(@on_conflict)}"
            sql << " #{build_update(@values_to_update)}"
          end

          sql
        end
      end
    end
  end
end
