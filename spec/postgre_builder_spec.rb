require "spec_helper"
require "sqlbuilder/builders/postgres_builder"

RSpec.describe Sqlbuilder::Builders::PostgresBuilder do
  let(:sql) do
    Sqlbuilder::Builders::PostgresBuilder.new
  end

  describe "select" do
    it "inherits behaviour from default builder" do
      query = sql.select
                 .from("Users")
                 .build

      expect(query).to eq "SELECT * FROM Users"
    end

    it "quotes string values" do
      query = sql.select
                 .from("Users")
                 .where(username: "john")
                 .build

      expect(query).to eq "SELECT * FROM Users WHERE \"username\" = 'john'"
    end

    it "can give aliases to tables" do
      query = sql.select
                .from("Players", aliaz: "p")
                .column("*", from: "p")
                .column("id", from: "t", as: "team_id")
                .column("name", from: "t", as: "team_name")
                .join("Teams", aliaz: "t", on: {team_id: :id})
                .build

      expect(query).to eq "SELECT p.*, t.\"id\" AS \"team_id\","\
                          " t.\"name\" AS \"team_name\""\
                          " FROM Players p"\
                          " INNER JOIN Teams t"\
                          " ON p.\"team_id\" = t.\"id\""
    end
  end

  describe "insert" do
    it "quotes all values and columns" do
      query = sql.insert
                 .into("Students")
                 .columns(%i[name age])
                 .values(["john", 20])
                 .values(["peter", 25])
                 .build

      expect(query).to eq "INSERT INTO Students (\"name\", \"age\")"\
                          " VALUES ('john', '20'), ('peter', '25')"
    end

    it "adds on conflict update functionality" do
      query = sql.insert
                 .into("Students")
                 .record(id: 1, name: "john", age: 20)
                 .on_conflict([:id])
                 .update(name: "john", age: 20)
                 .build

      expect(query).to eq "INSERT INTO Students (\"id\", \"name\", \"age\")"\
                          " VALUES ('1', 'john', '20') ON CONFLICT (id)"\
                          " DO UPDATE SET name = 'john', age = '20'"
    end
  end

  describe "update" do
    it "quotes all values" do
      query = sql.update
                 .table("Users")
                 .set(username: "john", age: 25)
                 .where(id: 2)
                 .build

      expect(query).to eq "UPDATE Users "\
                          "SET \"username\" = 'john', \"age\" = '25'"\
                          " WHERE id = '2'"
    end
  end

  describe "delete" do
    it "quotes values" do
      query = sql.delete
                 .from("Users")
                 .where(first_name: "john")
                 .build

      expect(query).to eq "DELETE FROM Users WHERE \"first_name\" = 'john'"
    end
  end

  describe "sequence" do
    it "can build a CREATE SEQUENCE query" do
      query = sql.sequence("user_id_seq")
                .create

      expect(query).to eq "CREATE SEQUENCE user_id_seq"
    end

    it "can build a query for selecting next value of sequence" do
      query = sql.sequence("user_id_seq")
                .next_val

      expect(query).to eq "SELECT nextval('user_id_seq')"
    end

    it "can build a query for selecting current value of sequence" do
      query = sql.sequence("user_id_seq")
                .current_val

      expect(query).to eq "SELECT currval('user_id_seq')"
    end

    it "can build a query for setting the value of sequence" do
      query = sql.sequence("user_id_seq")
                .set_val(5)

      expect(query).to eq "setval('user_id_seq', '5')"
    end
  end
end
