require_relative "../builder"
require_relative "../statements/postgres/insert"
require_relative "../statements/postgres/sequence"

require_relative "../utils/postgres"

module Sqlbuilder
  module Builders
    class PostgresBuilder < Sqlbuilder::Builder
      def initialize
        @utils = Utils::Postgres.new
      end

      def insert
        Statements::Postgres::Insert.new(@utils)
      end

      def sequence(name)
        Statements::Postgres::Sequence.new(name)
      end
    end
  end
end
