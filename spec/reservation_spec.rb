require_relative "spec_helper"

describe "Reservation class" do
  describe "initialize" do
    it "ia an instance of reservation" do
      start_date = Date.new(2018, 3, 5)
      end_date = start_date + 3
      id = 8,
      room_id = 10,
      reservation = Reservation.new(id, room_id, start_date, end_date)
      expect(reservation).must_be_kind_of Reservation
    end
    it "raise an ArgumentError if end_date is before start_date" do
      start_date = Date.new(2018, 5, 20)
      end_date = Date.new (2018, 5, 18)
      id = 8,
      room_id = 10,
      reservation = Reservation.new(id, room_id, start_date, end_date)
      excpect(reservation).must_raise ArgumentError
    end
    # it "makes an array of dates that include in that reservation" do
    # end
  end
end
