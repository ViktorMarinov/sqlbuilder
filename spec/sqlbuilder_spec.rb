require "spec_helper"
require "sqlbuilder/builder"
require "sqlbuilder/dialects/default"

RSpec.describe Sqlbuilder do
  it "has a version number" do
    expect(Sqlbuilder::VERSION).not_to be nil
  end

  describe 'select' do
  	let(:sql) do
      dialect = Sqlbuilder::Dialects::Default.new
  	  Sqlbuilder::Builder.new(dialect)
  	end

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
end
