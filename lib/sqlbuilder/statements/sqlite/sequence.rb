module Sqlbuilder
  module Statements
    module Sqlite
      class Sequence
        def initialize(name)
          @name = name
        end

        def create
          "CREATE TABLE #{@name} (id INTEGER)"
        end

        def create_unless_exists
          "CREATE TABLE IF NOT EXISTS #{@name} (id INTEGER)"
        end

        def next_val
          "SELECT nextval('#{@name}')"
        end

        def current_val
          "SELECT currval('#{@name}')"
        end

        def set_val(new_value)
          "setval('#{@name}', '#{new_value}')"
        end
      end
    end
  end
end
