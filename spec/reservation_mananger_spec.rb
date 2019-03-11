require_relative "spec_helper"

describe "Reservation Manager class initialization" do
  it "will return an instance of Reservation_Manager" do
    test_manager = Reservation_Manager.new
    expect(test_manager).must_be_kind_of Reservation_Manager
    expect(test_manager.reservations).must_be_kind_of Array
  end

  it "will contain a collection of Reservation instances" do
  end
end
