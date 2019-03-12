require_relative 'spec_helper'

describe "Reserve" do 
  before do 
    @reserved = Reservation.new(
                      id: 1, 
                      start_date: "2019-03-03",
                      end_date: "2019-05-03", 
                      room_booked: 1)
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

  describe "make_reservation" do 
    before do 
      @reserved = Reservation.new(
        id: 1, 
        start_date: "March 10 2019",
        end_date: "March 15th 2019", 
        room_booked: 1)
      @reservations = Reservation.make_reservation(@reserved)
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