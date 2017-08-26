require_relative '../generators/delete_generator'

module Sqlbuilder
  module Statements
    class Delete
      include Generators::DeleteGenerator

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

        sql << " #{build_from(@table)}"
        sql << " #{build_where(@where)}" if @where

        sql
      end
    end
  end
end
