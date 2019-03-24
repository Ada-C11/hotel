require_relative "spec_helper"
describe "Reservation Class" do
  describe "initialize" do
    before do
      room_num = 5
      check_in = Date.parse("2019-05-14")
      check_out = Date.parse("2019-05-18")
      rate = 200
      rooms = []
      rooms << Room.new(id: 1)
      rooms << Room.new(id: 2)
      rooms << Room.new(id: 3)

      @reservation_data = {
        room_num: 5,
        check_in: check_in.to_s,
        check_out: check_out.to_s,
        rooms: rooms,

      }
      @reservation = Reservation.new(@reservation_data)
    end

    it "has a check-out date that is after the check-in date." do
      expect(@reservation.check_out > @reservation.check_in).must_equal true
    end

    it "throws ArgumentError when check-out date is before the check-in date." do
      expect do
        Reservation.new(room_num: 7, check_in: "2019-05-14", check_out: "2019-05-13", rate: 200)
      end.must_raise ArgumentError
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Reservation
    end

    it "calculates the total cost of the stay" do
      expect(@reservation.total_cost).must_equal 800
      puts "This reservation will cost $#{@reservation.total_cost}."
    end
  end
end
