require_relative "spec_helper"

describe "sample class" do
  it "is able to instantiate" do
    instance = Sample.new("this is an argument")

    expect(instance).must_be_kind_of Sample
  end
end
