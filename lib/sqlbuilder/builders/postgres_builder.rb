require_relative "../builder"
require_relative "../statements/postgres/insert"
require_relative "../statements/postgres/select"
require_relative "../statements/postgres/update"
require_relative "../statements/postgres/delete"
require_relative "../statements/postgres/sequence"

module Sqlbuilder
  module Builders
    class PostgresBuilder < Sqlbuilder::Builder
      def insert
        Statements::Postgres::Insert.new
      end

      def select
        Statements::Postgres::Select.new
      end

      def update
        Statements::Postgres::Update.new
      end

      def delete
        Statements::Postgres::Delete.new
      end

      def sequence(name)
        Statements::Postgres::Sequence.new(name)
      end
    end
  end
end
