require_relative "../insert"
require_relative "../builders/postgres/insert_builder"

module Sqlbuilder
  module Statements
    module Postgres
      class Insert < Statements::Insert
        include Builders::Postgres::InsertBuilder

        def on_conflict(conflict_target)
          @conflict_target = conflict_target

          self
        end

        def update(values_to_update)
          @values_to_update = values_to_update

          self
        end

        def build
          sql = super

          if @conflict_target
            sql << " #{build_on_conflict}"
            sql << " #{build_update}"
          end

          sql
        end
      end
    end
  end
end
