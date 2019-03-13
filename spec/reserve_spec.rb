require_relative 'spec_helper'

describe "Reserve" do 
  before do 
    @reserved = Reservation.new(id: 1,
                      check_in: "2019-03-03",
                      check_out: "2019-05-03",
                      room_booked: 1,
                      total_cost: 400.00)
  end
  describe "initialize" do
    it "knows reserve is an instance of Reservation" do 
      expect(@reserved).must_be_kind_of Reservation
    end

    it "knows the reservation id" do
      expect(@reserved).must_respond_to :id
      expect(@reserved.id).must_equal 1
    end
  end
end