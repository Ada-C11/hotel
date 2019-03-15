require_relative "spec_helper"

describe "reservation class" do
  describe "initialize" do
    before do
      @room = HotelGroup::Room.new(3, 200)
      @res = HotelGroup::Reservation.new(1, Date.new(2019, 3, 10), Date.new(2019, 3, 12), @room)
    end
    it "returns an instance of class HotelGroup::Reservation" do
      expect(@res).must_be_kind_of HotelGroup::Reservation
    end

    it "finds total price based on number of days in reservation" do
      @res.room = HotelGroup::Room.new(21, 200)
      expect(@res.total_price).must_equal "400.00"
    end
  end

  describe "finds a reservation by date" do
    before do
      @room = HotelGroup::Room.new(3, 200)
      @res = HotelGroup::Reservation.new(1, Date.new(2019, 3, 3), Date.new(2019, 3, 6), @room)
    end

    it "includes_date? returns true for date within res date range" do
      date = Date.new(2019, 3, 4)

      expect(@res.includes_date?(date)).must_equal true
    end

    it "includes_date? returns false for date outside res date range" do
      date = Date.new(2019, 3, 7)

      expect(@res.includes_date?(date)).must_equal false
    end

    it "prints itself nicely" do
      expect(@res.print_nicely).must_equal "Reservation 1: Room 3 from 2019-03-03 to 2019-03-06. Total cost: $600.00"
    end
  end

  describe "it loads data from csv file" do
    before do
      @file_path = "spec/test_data/reservations.csv"

      @res_list = HotelGroup::Reservation.load_all(full_path: @file_path)
    end

    it "gets the list of reservations" do
      expect(@res_list.count).must_equal 4
    end

    it "reads the reservations accurately" do
      expect(@res_list[0].room).must_equal 1
      expect(@res_list.last.room).must_equal 3
    end
  end
end
