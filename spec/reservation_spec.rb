require_relative "spec_helper"

describe "Reservation class" do
  describe "initialize" do
    before do
      start_date = Date.parse("2018-05-20")
      end_date = start_date + 3
      id = 8,
           room_id = 10,
      @reservation = Reservation.new(id, room_id, start_date, end_date)
      it "ia an instance of reservation" do
        expect(@reservation).must_be_kind_of Reservation
      end
      it "raise an ArgumentError if end_date is before start_date" do
        start_date = Date.parse("2018-05-20")
        end_date = start_date - 3
        id = 8,
             room_id = 10,
        reservation = Reservation.new(id, room_id, start_date, end_date)
        excpect(reservation).must_raise ArgumentError
      end
    end
  end
end
