module Sqlbuilder
  module Statements
    module Postgres
      class Sequence
        def initialize(name)
          @name = name
        end

        def create
          "CREATE SEQUENCE #{@name}"
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
