require_relative "../generators/insert_generator"

module Sqlbuilder
  module Statements
    class Insert
      include Generators::InsertGenerator

      def initialize
        @columns = []
        @values_array = []
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
        @values_array << single_row_values

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

          @records.each {|record| @values_array << record.values }
        end

        sql << " #{build_into(@table)}"
        sql << " #{build_columns(@columns)}"
        sql << " #{build_values(@values_array)}"

        sql
      end
    end
  end
end
