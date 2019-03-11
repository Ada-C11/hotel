require_relative "spec_helper"

describe "Reservation class" do
  describe "initialize" do
    it "Creates an instance of reservation" do
      reservation = Reservation.new
      expect(reservation).must_be_instance_of Reservation
    end
    it "Reservation class initialized with nil start  date if no date is given" do
      reservation = Reservation.new
      expect(reservation.start_date).must_equal nil
    end
    it "Reservation class initialized with nil  end date if no date is given" do
      reservation = Reservation.new
      expect(reservation.end_date).must_equal nil
    end
    it "Reservation id initialized as 0 if no reservation id is entered" do
      reservation = Reservation.new
      expect(reservation.reservation_id).must_equal 0
    end
  end
  describe "duration method" do
    it "Duration returns the length of time between 2 dates" do
      reservation = Reservation.new(start_date: "1st Mar 2019", end_date: "8th Mar 2019")
      expect(reservation.duration).must_equal 7
    end
    it "Raises an ArgumentError if the duration is less than 1 day" do
      reservation = Reservation.new(start_date: "7th Mar 2019", end_date: "6th Mar 2019")
      expect { reservation.duration }.must_raise ArgumentError
    end
    it "Can calulate duration between 2 months" do
      reservation = Reservation.new(start_date: "28th Feb 2019", end_date: "7th Mar 2019")
      expect(reservation.duration).must_equal 7
    end
  end
  describe "total_cost method" do
    it "Can calcute cost of stay" do
      reservation = Reservation.new(start_date: "1st Mar 2019", end_date: "8th Mar 2019")
      expect(reservation.total_cost).must_equal 1400
    end
  end
  describe "assign_room method" do
    it "assigns a room from @rooms array" do
      rooms = ("1".."20").to_a
      reservation = Reservation.new
      room = reservation.assign_room
      expect(rooms.include?(room)).must_equal true
    end
  end
end
