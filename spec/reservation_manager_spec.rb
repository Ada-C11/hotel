require_relative "spec_helper"

describe "Reservation_manager" do
  it "creates instance of reservation_manager" do
    expect(Reservation_manager.new).must_be_instance_of Reservation_manager
  end
end
