require_relative "builders/insert_builder"

module Sqlbuilder
  module Statements
    class Insert
      include Builders::InsertBuilder

      def initialize(utils)
        @utils = utils
        @columns = []
        @values_list = []
        @records = []
      end

      def into(table)
        @table = table

        self
      end

      def columns(columns)
        @columns = columns

        self
      end

      def values(single_row_values)
        @values_list << single_row_values

        self
      end

      def record(key_value_hash)
        @records << key_value_hash

        self
      end

      def build
        sql = "INSERT"

        unless @records.empty?
          @columns = @records.first.keys

          @records.each {|record| @values_list << record.values }
        end

        sql << " #{build_into}"
        sql << " #{build_columns}"
        sql << " #{build_values}"

        sql
      end
    end
  end
end
