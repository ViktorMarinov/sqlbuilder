require_relative "../generators/select_generator"

module Sqlbuilder
  module Statements
    class Select
      include Generators::SelectGenerator

      def initialize(utils)
        @utils = utils
        @columns = []
        @joins = []
      end

      def columns(columns)
        @columns = columns

        self
      end

      def column(column, as: nil)
        @columns << {col: column, as: as}

        self
      end

      def from(table, aliaz: nil)
        @table = table
        @aliaz = aliaz
        self
      end

      def where(query_hash)
        @where = query_hash

        self
      end

      def order(order_hash)
        @order = order_hash

        self
      end

      def limit(limit)
        @limit = limit

        self
      end

      def offset(offset)
        @offset = offset

        self
      end

      def join(from, type: "INNER", aliaz: nil, on: {})
        @joins << {
          from: from,
          type: type,
          aliaz: aliaz,
          on: on
        }

        self
      end

      def build
        sql = "SELECT"
        sql << " #{build_columns}"
        sql << " #{build_from}"
        sql << " #{build_joins}" unless @joins.empty?
        sql << " #{build_where}" if @where && !@where.empty?
        sql << " #{build_order}" if @order && !@order.empty?
        sql << " #{build_limit}" if @limit
        sql << " #{build_offset}" if @offset

        sql
      end
    end
  end
end
