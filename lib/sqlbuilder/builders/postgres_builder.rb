require_relative '../builder'
require_relative '../statements/postgres/insert'

module Sqlbuilder
  module Builders
    class PostgresBuilder < Sqlbuilder::Builder
      def insert
        Statements::Postgres::Insert.new(@dialect.insert_builder)
      end

      def sequence(name)
        Statements::Sequence.new(@dialect.sequence_builder, name)
      end
    end
  end
end
