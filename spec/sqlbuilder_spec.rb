require "spec_helper"
require "sqlbuilder/builder"

RSpec.describe Sqlbuilder do
  it "has a version number" do
    expect(Sqlbuilder::VERSION).not_to be nil
  end
end
