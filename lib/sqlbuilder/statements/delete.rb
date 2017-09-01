require_relative "../generators/delete_generator"

module Sqlbuilder
  module Statements
    class Delete
      include Generators::DeleteGenerator

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
