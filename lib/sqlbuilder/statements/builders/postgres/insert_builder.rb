require_relative "../insert_builder"

module Sqlbuilder
  module Statements
    module Builders
      module Postgres
        module InsertBuilder
          include Builders::InsertBuilder

          def build_on_conflict
            "ON CONFLICT (#{@conflict_target.join(',')})"
          end

          def build_update
            set_list = @values_to_update.map do |key, value|
              "#{key} = #{@utils.format_value(value)}"
            end

            "DO UPDATE SET #{set_list.join(", ")}"
          end
        end
      end
    end
  end
end
