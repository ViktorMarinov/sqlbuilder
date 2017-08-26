require "spec_helper"
require "sqlbuilder/builders/postgres_builder"

RSpec.describe Sqlbuilder::Builders::PostgresBuilder do
  let(:sql) do
    Sqlbuilder::Builders::PostgresBuilder.new()
  end

  describe 'select' do
    it 'inherits behaviour from default builder' do
      query = sql.select()
                .from("Users")
                .build()

      expect(query).to eq "SELECT * FROM Users"
    end

    it 'quotes string values' do
      query = sql.select()
                .from("Users")
                .where({username: 'john'})
                .build()

      expect(query).to eq "SELECT * FROM Users WHERE username = 'john'"
    end
  end

  describe 'insert' do
    it 'quotes all values' do
      query = sql.insert()
                .into("Students")
                .columns([:name, :age])
                .values(['john', 20])
                .values(['peter', 25])
                .build()

      expect(query).to eq "INSERT INTO Students (name, age) VALUES ('john', '20'), ('peter', '25')"
    end

    it 'adds on conflict update functionality' do
      query = sql.insert()
                .into("Students")
                .record({name: 'john', age: 20})
                .build()

      expect(query).to eq "INSERT INTO Students (name, age) VALUES ('john', '20')"
    end
  end

  describe 'update' do
    it 'quotes all values' do
      query = sql.update()
                .table("Users")
                .set({username: 'john', age: 25})
                .where({id: 2})
                .build()

      expect(query).to eq "UPDATE Users SET username = 'john', age = '25' WHERE id = '2'"
    end
  end

  describe 'delete' do
    it 'quotes values' do
      query = sql.delete()
                .from("Users")
                .where({first_name: 'john'})
                .build()

      expect(query).to eq "DELETE FROM Users WHERE first_name = 'john'"
    end
  end
end
