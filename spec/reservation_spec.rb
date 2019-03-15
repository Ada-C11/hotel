require_relative "spec_helper"

describe "Reservation" do
  describe "instantiation" do
    before do
      @reservation = Hotel::Reservation.new(
        id: 1,
        date_range: Hotel::DateRange.new("03-04-2019", "06-04-2019"),
        room: Hotel::Room.new(id: 1),
        price: 200,
      )
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it "is set up for specific attributes and data types" do
      [:id, :date_range, :room, :price].each do |prop|
        expect(@reservation).must_respond_to prop
      end

      expect(@reservation.id).must_be_kind_of Integer
      expect(@reservation.date_range).must_be_instance_of Hotel::DateRange
      expect(@reservation.room).must_be_instance_of Hotel::Room
      expect(@reservation.price).must_be_kind_of Integer
    end
  end

  describe "total_price method" do
    before do
      @reservation = Hotel::Reservation.new(
        id: 1,
        date_range: Hotel::DateRange.new("03-04-2019", "06-04-2019"),
        room: Hotel::Room.new(id: 1),
        price: 200,
      )
    end

    it "calculates the correct price" do
      expect(@reservation.total_price).must_equal 600
    end
  end

  describe "overlap method" do
    before do
      @reservation = Hotel::Reservation.new(
        id: 1,
        date_range: Hotel::DateRange.new("03-04-2019", "06-04-2019"),
        room: Hotel::Room.new(id: 1),
        price: 200,
      )
    end

    it "detects an overlapping date range" do
      before_range = "02-04-2019"
      start_date = "03-04-2019"
      during_range1 = "04-04-2019"
      during_range2 = "05-04-2019"
      end_date = "06-04-2019"
      after_range = "07-04-2019"

      range1 = Hotel::DateRange.new(before_range, during_range1)
      range2 = Hotel::DateRange.new(before_range, end_date)
      range3 = Hotel::DateRange.new(before_range, after_range)
      range4 = Hotel::DateRange.new(start_date, during_range1)
      range4 = Hotel::DateRange.new(start_date, end_date)
      range5 = range4 = Hotel::DateRange.new(start_date, after_range)
      range6 = Hotel::DateRange.new(during_range1, during_range2)
      range7 = Hotel::DateRange.new(during_range1, end_date)
      range8 = Hotel::DateRange.new(during_range1, after_range)

      ranges = [range1, range2, range3, range4, range5, range6, range7, range8]

      ranges.each do |range|
        expect(@reservation.overlap?(range)).must_equal true
      end
    end

    it "detects an available date" do
      before_range1 = "01-04-2019"
      before_range2 = "02-04-2019"
      start_date = "03-04-2019"
      end_date = "06-04-2019"
      after_range1 = "07-04-2019"
      after_range2 = "08-04-2019"

      range9 = Hotel::DateRange.new(before_range1, before_range2)
      range10 = Hotel::DateRange.new(before_range2, start_date)
      range11 = Hotel::DateRange.new(end_date, after_range1)
      range12 = Hotel::DateRange.new(after_range1, after_range2)

      ranges = [range9, range10, range11, range12]
      ranges.each do |range|
        expect(@reservation.overlap?(range)).must_equal false
      end
    end
  end
end
