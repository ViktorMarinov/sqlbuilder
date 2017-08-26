module Sqlbuilder
  module Statements
    class Sequence
      def initialize(name)
        @name = name
      end

      def create
        @sequence_builder.create(@name)
      end

      def next_val
        @sequence_builder.next_val(@name)
      end

      def current_val
        @sequence_builder.current_val(@name)
      end

      def set_val(new_value)
        @sequence_builder.set_val(@name, new_value)
      end
    end
  end
end
