require_relative "../insert_generator"

module Sqlbuilder
  module Generators
    module Postgres
      module InsertGenerator
        include Generators::InsertGenerator

        def build_on_conflict(conflict_target)
          "ON CONFLICT (#{conflict_target.join(',')})"
        end

        def build_update(updates)
          set_list = updates.map do |key, value|
            "#{key} = #{format_single_value(value)}"
          end

          "DO UPDATE SET #{set_list.join(", ")}"
        end
      end
    end
  end
end
