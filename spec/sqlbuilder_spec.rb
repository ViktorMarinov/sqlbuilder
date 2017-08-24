require "spec_helper"
require "sqlbuilder/builder"
require "sqlbuilder/dialects/default"

RSpec.describe Sqlbuilder do
  it "has a version number" do
    expect(Sqlbuilder::VERSION).not_to be nil
  end

  let(:sql) do
    dialect = Sqlbuilder::Dialects::Default.new
    Sqlbuilder::Builder.new(dialect)
  end

  describe 'select' do
  	it 'can create a basic select statement' do
  		query = sql.select()
  							.from("Users")
                .build()

  		expect(query).to eq "SELECT * FROM Users"
   	end

    it 'can create a select statement with where' do
      query = sql.select()
                .from("Users")
                .where({username: 'john'})
                .build()

      expect(query).to eq "SELECT * FROM Users WHERE username = john"
    end

    it 'can create a select with order by' do
      query = sql.select()
                .from("Users")
                .order({username: :ASC})
                .build()

      expect(query).to eq "SELECT * FROM Users ORDER BY username ASC"
    end

    it 'can create a select with limit and offset' do
      query = sql.select()
                .from("Users")
                .where({age: 20})
                .limit(20)
                .offset(10)
                .build()

      expect(query).to eq "SELECT * FROM Users WHERE age = 20 LIMIT 20 OFFSET 10"
    end
  end

  describe 'insert' do
    it 'can create an insert with single column' do
      query = sql.insert()
                .into("Students")
                .record({name: 'john'})
                .build()

      expect(query).to eq "INSERT INTO Students (name) VALUES ('john')"
    end

    it 'can create an insert with multiple columns' do
      query = sql.insert()
                .into("Students")
                .record({name: 'john', age: 20})
                .build()

      expect(query).to eq "INSERT INTO Students (name, age) VALUES ('john', '20')"
    end

    it 'can create an insert using columns and values methods' do
      query = sql.insert()
                .into("Students")
                .columns([:name, :age])
                .values(['john', 20])
                .values(['peter', 25])
                .build()

      expect(query).to eq "INSERT INTO Students (name, age) VALUES ('john', '20'), ('peter', '25')"
    end
  end

  # describe 'update' do
  #   it 'can create a basic update statement' do
  #     query = sql.update()
  #               .table("Users")
  #               .set({username: 'john', age: 25})

  #     expect(query).to eq "UPDATE Users SET username = \"john\", age = 25"
  #   end
  # end
end
