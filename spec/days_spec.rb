require "date"

require_relative "spec_helper"

describe "Date class instatiations" do
  before do
    @dates = Hotel::Days.new(
      in_date: Date.new(2019, 3, 13),
      out_date: Date.new(2019, 3, 16),
    )
  end

  it "is an instance of Days" do
    expect(@dates).must_be_kind_of Hotel::Days
  end
end
