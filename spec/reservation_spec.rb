require_relative "spec_helper"
describe "Reservation Class" do
  describe "initialize" do
    before do
      check_in = Date.parse("2019-05-14")
      check_out = Date.parse("2019-05-18")
      rooms = []
      rooms << Room.new(id: 1)
      rooms << Room.new(id: 2)
      rooms << Room.new(id: 3)

      @reservation_data = {

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
        Reservation.new(id: 2, check_in: "2019-05-14", check_out: "2019-05-13", cost: 200)
      end.must_raise ArgumentError
    end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Reservation
    end

    it "provides duration in days" do
      expect(@reservation.duration).must_equal 4
      puts "This reservation is #{@reservation.duration} days."
    end

    it "calculates the total cost of the stay" do
      expect(@reservation.total_cost).must_equal 800
      puts "This reservation will cost $#{@reservation.total_cost}."
    end

    # it "is set up for specific attributes and data types" do
    #   [:check_in, :check_out, :rooms].each do |prop|
    #     expect(@reservation).must_respond_to prop
    #   end
    #   expect(@reservation.check_in).must_be_kind_of Date
    #   expect(@reservation.check_out).must_be_kind_of Date
    #   # expect(@reservation.rooms).must_be_kind_of Integer
    # end
  end
end
