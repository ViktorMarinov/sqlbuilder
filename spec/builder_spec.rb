require "spec_helper"
require "sqlbuilder/builder"

RSpec.describe Sqlbuilder::Builder do
  let(:sql) do
    Sqlbuilder::Builder.new
  end

  describe "select" do
    it "can create a basic select statement" do
      query = sql.select
                 .from("Users")
                 .build

      expect(query).to eq "SELECT * FROM Users"
    end

    it "can create a select statement with where" do
      query = sql.select
                 .from("Users")
                 .where(username: "john")
                 .build

      expect(query).to eq "SELECT * FROM Users WHERE username = john"
    end

    it "can create a select with inequalities in where" do
      query = sql.select
                 .from("Users")
                 .where(age: "> 14")
                 .build

      expect(query).to eq "SELECT * FROM Users WHERE age > 14"
    end

    it "can combine equality and inequality in a query" do
      query = sql.select
                 .from("Users")
                 .where(age: 20, username: "!= Gosho")
                 .build

      expect(query).to eq "SELECT * FROM Users WHERE age = 20 AND username != Gosho"
    end

    it "can create a select with order by" do
      query = sql.select
                 .from("Users")
                 .order(username: :ASC)
                 .build

      expect(query).to eq "SELECT * FROM Users ORDER BY username ASC"
    end

    it "can create a select with limit and offset" do
      query = sql.select
                 .from("Users")
                 .limit(20)
                 .offset(10)
                 .build

      expect(query).to eq "SELECT * FROM Users LIMIT 20 OFFSET 10"
    end

    it 'can create a select with join' do
      query = sql.select
                .from("Players")
                .join("Teams")
                .build

      expect(query).to eq "SELECT * FROM Players INNER JOIN Teams"
    end

    it 'can create join on columns' do
      query = sql.select
                .from("Players")
                .join("Teams", on: {team_id: :id})
                .build

      expect(query).to eq "SELECT * FROM Players"\
                          " INNER JOIN Teams"\
                          " ON Players.team_id = Teams.id"

    end

    it 'can build queries with aggregations' do
      query = sql.select
                .from("Products")
                .column("COUNT(*)")
                .build

      expect(query).to eq "SELECT COUNT(*) FROM Products"
    end

    it 'can combine aggregations with where' do
      query = sql.select
                .from("Products")
                .column("COUNT(id)")
                .where(price: "> 150")
                .build

      expect(query).to eq "SELECT COUNT(id) FROM Products"\
                          " WHERE price > 150"
    end

    it 'can give aliases to tables' do
      query = sql.select
                .from("Players", aliaz: 'p')
                .column("*", from: 'p')
                .column("id", from: 't', as: 'team_id')
                .column("name", from: 't', as: 'team_name')
                .join("Teams", aliaz: 't', on: {team_id: :id})
                .build

      expect(query).to eq "SELECT p.*, t.id AS team_id, t.name AS team_name"\
                          " FROM Players p"\
                          " INNER JOIN Teams t"\
                          " ON p.team_id = t.id"
    end
  end

  describe "insert" do
    it "can create an insert with single column" do
      query = sql.insert
                 .into("Students")
                 .record(name: "john")
                 .build

      expect(query).to eq "INSERT INTO Students (name) VALUES (john)"
    end

    it "can create an insert with multiple columns" do
      query = sql.insert
                 .into("Students")
                 .record(name: "john", age: 20)
                 .build

      expect(query).to eq "INSERT INTO Students (name, age) VALUES (john, 20)"
    end

    it "can create an insert using columns and values methods" do
      query = sql.insert
                 .into("Students")
                 .columns(%i[name age])
                 .values(["john", 20])
                 .values(["peter", 25])
                 .build

      expect(query).to eq "INSERT INTO Students (name, age) VALUES (john, 20), (peter, 25)"
    end
  end

  describe "update" do
    it "can create a basic update statement" do
      query = sql.update
                 .table("Users")
                 .set(username: "john", age: 25)
                 .build

      expect(query).to eq "UPDATE Users SET username = john, age = 25"
    end

    it "can create an update with where clause" do
      query = sql.update
                 .table("Users")
                 .set(username: "john", age: 25)
                 .where(id: 2)
                 .build

      expect(query).to eq "UPDATE Users SET username = john, age = 25 WHERE id = 2"
    end
  end

  describe "delete" do
    it "can create a delete all statement" do
      query = sql.delete
                 .from("Users")
                 .build

      expect(query).to eq "DELETE FROM Users"
    end

    it "can create a delete with where" do
      query = sql.delete
                 .from("Users")
                 .where(first_name: "john")
                 .build

      expect(query).to eq "DELETE FROM Users WHERE first_name = john"
    end
  end
end
