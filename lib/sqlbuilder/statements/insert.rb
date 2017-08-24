module Sqlbuilder
  module Statements
    class Insert

      def initialize(insert_builder)
        @insert_builder = insert_builder
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

          @records.each { |record| @values_array << record.values}
        end

        sql << " #{@insert_builder.into(@table)}"
        sql << " #{@insert_builder.columns(@columns)}"
        sql << " #{@insert_builder.values(@values_array)}"

        sql
      end
    end
  end
end
