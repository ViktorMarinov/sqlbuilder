require_relative '../generators/update_generator'

module Sqlbuilder
  module Statements
    class Update
      include Generators::UpdateGenerator

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

        sql << " #{build_set(@set)}"
        sql << " #{build_where(@where)}" if @where

        sql
      end
    end
  end
end
