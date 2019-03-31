require_relative "spec_helper"

describe "Reserve" do
  before do 
    @room = 3
    @first_day = Date.parse("March 1st 2025")
    @last_day = Date.parse("March 3rd 2025")
    @rate = 200
    @reservy = Reservation.new(@room, @first_day, @last_day, @rate)
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      @reservy.must_be_kind_of Reservation
      @reservy.must_respond_to :room_booked
      @reservy.must_respond_to :rate
    end

    it "is a kind of DateRange" do 
      @reservy.must_be_kind_of DateRange
    end
  end

  describe "total cost" do 
    it "calculates total cost for dates booked" do
      expected_price = @rate * (@last_day - @first_day)
      @reservy.total_cost.must_equal expected_price
    end
  end
end
