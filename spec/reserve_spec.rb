require_relative 'spec_helper'

describe "Reserve" do 
  before do 
    @reserve = Reservation.new(
                      id: 1, 
                      start_date: "March 10 2019",
                      end_date: "March 15th 2019", 
                      room_booked: 1)
  end
  describe "initialize" do
    it "knows reserve is an instance of Reservation" do 
      expect(@reserve).must_be_kind_of Reservation
    end

    it "knows the reservation id" do
      expect(@reserve).must_respond_to :id
      expect(@reserve.id).must_equal 1
    end
  end

  describe "add_reservation" do 
    before do 
      @reservations = Reservation.add_reservation
    end
    it "returns and array of reservations" do 
      expect(@reservations).must_be_kind_of Array
    end

    it "verifies each reservation in the array is an instance of Reservation" do 
      @reservations.each do |res|
        res.must_be_kind_of Reservation
      end
    end

  end
end