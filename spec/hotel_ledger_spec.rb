require_relative "spec_helper"

describe "Hotel Ledger class" do
  before do
    @rooms = Hotel::Hotel_ledger.new
  end

  #   it "must return an array for all rooms" do
  #     expect(@rooms.list_all_rooms).must_be_kind_of Array
  #   end

  it "can list all the hotel rooms" do
    expect(@rooms.list_all_rooms).must_equal 1..20
  end
end
