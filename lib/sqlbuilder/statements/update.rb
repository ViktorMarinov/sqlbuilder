module Sqlbuilder
  module Statements
    class Update

      def initialize(update_builder)
        @update_builder = update_builder
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

        sql << " #{@update_builder.set(@set)}"
        sql << " #{@update_builder.where(@where)}" if @where

        sql
      end
    end
  end
end
