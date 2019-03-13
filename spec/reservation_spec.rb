require_relative "spec_helper"
describe "Reservation Class" do
  describe "initialize" do
    before do
      check_in = Date.parse("2019-05-14")
      check_out = Date.parse("2019-05-18")

      @reservation_data = {
        id: 1,
        check_in: check_in.to_s,
        check_out: check_out.to_s,
        cost: 200,
        hotel_block: nil,

      }
      @reservation = Hotel::Reservation.new(@reservation_data)
    end

    it "has a check-out date that is after the check-in date." do
      expect(@reservation.check_out > @reservation.check_in).must_equal true
    end

    it "throws ArgumentError when check-out date is before the check-in date." do
      expect do
        Hotel::Reservation.new(id: 2, check_in: "2019-05-14", check_out: "2019-05-13", cost: 200,
                               hotel_block: nil)
      end.must_raise ArgumentError
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "provides duration in days" do
      expect(@reservation.duration).must_equal 4
      puts "This reservation is #{@reservation.duration} days."
    end
  end
end
