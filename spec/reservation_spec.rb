require "spec_helper"

describe "Reservation class" do
  describe "initialize" do
    before do
      @res1 = Reservation.new(name: "Jane", room_id: 2, start_date: "2019-04-11", end_date: "2019-04-14")
    end
    it "is an instance of reservation" do
      expect(@res1).must_be_kind_of Reservation
    end
    it "return the correct start-date" do
      expect(@res1.start_date).must_equal Date.parse("2019-04-11")
    end
    it "return a correct date range" do
      expect((@res1.end_date - @res1.start_date).to_i).must_equal 3
    end
  end

  describe "Reservation#date_is_valid?" do
    it "raise argument error when the start_date is after end_date" do
      expect { Reservation.new(name: "Jane", room_id: 2, start_date: "2019-05-14 ", end_date: "2019-04-14") }.must_raise ArgumentError
    end
    it "raise argument error when the start_date is empty" do
      expect { Reservation.new(name: "Jane", room_id: 2, start_date: " ", end_date: "2019-04-14") }.must_raise ArgumentError
    end
  end

  describe "Reservation#total_cost" do
    before do
      @res1 = Reservation.new(name: "Jane", room_id: 2, start_date: "2019-04-11", end_date: "2019-04-14")
    end
    it "return a correct total cost for a given reservation" do
      expect (@res1.total_cost).must_equal 600
    end
  end
end
