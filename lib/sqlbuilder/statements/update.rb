require_relative "builders/update_builder"

module Sqlbuilder
  module Statements
    class Update
      include Builders::UpdateBuilder

      def initialize(utils)
        @utils = utils
      end

      def table(table)
        @table = table

        self
      end

      def set(set)
        @set = set

        self
      end

      def where(filter_hash)
        @where = filter_hash

        self
      end

      def build
        sql = "UPDATE #{@table}"

        sql << " #{build_set}"
        sql << " #{build_where}" if @where

        sql
      end
    end
  end
end
