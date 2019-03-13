require_relative "spec_helper"

# module Hotel
describe "class FrontDesk" do
  def build_front_desk
    return Hotel::FrontDesk.new
  end

  describe "all_rooms array" do
    before do
      @rooms = build_front_desk
    end

    it "will say all_rooms is an array with a length of 20" do
      expect(@rooms.all_rooms_array).must_be_kind_of Array
      expect(@rooms.all_rooms_array.length).must_equal 20
    end
  end

  describe "make_reservation and add_reservation methods" do
    before do
      @new_reservation = build_front_desk
    end
    it "adds reservation to reservations array" do
      reservation_1 = @new_reservation.make_reservation(
        1201,
        1,
        Date.new(2019, 3, 20),
        Date.new(2019, 3, 22),
      )
      puts "VVVVVVVVVVVVVV"
      puts reservation_1
      puts "^^^^^^^^^^^^^^"
      @new_reservation.add_reservation(reservation_1)
      expect(@new_reservation.reservations_array.length).must_be :>, 0
      expect(@new_reservation.reservations_array[0].total_cost).must_equal 400
    end
  end

  describe "get reservation by a specific date" do
    before do
      @specific_reservation = build_front_desk
    end
    it "will get a reservation by a date" do
      reservation_2 = @specific_reservation.make_reservation(
        1011,
        2,
        Date.new(2019, 4, 8),
        Date.new(2019, 4, 10),
      )
      puts "VVVVVVVVVVVVVV"
      puts reservation_2
      puts "^^^^^^^^^^^^^^"
      @specific_reservation.add_reservation(reservation_2)

      by_date = @specific_reservation.get_reservation_by_date(Date.new(2019, 4, 8), Date.new(2019, 4, 10))

      puts "VVVVVVVVVVVVVV"
      puts by_date
      puts "^^^^^^^^^^^^^^"
      expect(by_date).must_be_kind_of Array
      expect(by_date[0].start_date).must_equal Date.new(2019, 4, 8)
    end
  end
end
# end
