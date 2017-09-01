require_relative "builders/delete_builder"

module Sqlbuilder
  module Statements
    class Delete
      include Builders::DeleteBuilder

      def initialize(utils)
        @utils = utils
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

        sql << " #{build_from}"
        sql << " #{build_where}" if @where && !@where.empty?

        sql
      end
    end
  end
end
