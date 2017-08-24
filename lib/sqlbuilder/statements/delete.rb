module Sqlbuilder
  module Statements
    class Delete

      def initialize(delete_builder)
        @delete_builder = delete_builder
      end

      def from(table)
        @table = table

        self
      end

      def where(where)
        @where = where

        self
      end

      def build
        sql = "DELETE"

        sql << " #{@delete_builder.from(@table)}"
        sql << " #{@delete_builder.where(@where)}" if @where

        sql
      end
    end
  end
end
