require_relative 'spec_helper'

describe "Reserve" do 
  before do 
    @reservations = Hotel::Reservation.new(
                      id: 1, 
                      dates: "March 10 2019 - March 15th 2019", 
                      rooms_booked: [1, 3, 5],
                      total_cost: $1000)
  end
  describe "initialize" do
    it "reservation is an instance of Reserve" do 
      expect(@reservations).must_be_kind_of Hotel::Reservation
    end

    it "knows the reservation id" do
      expect(@reservations).must_respond_to id
      expect(@reservations).id.must_equal 1
    end
  end
end