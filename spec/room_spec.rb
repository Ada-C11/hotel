require_relative "spec_helper"

describe "room class" do
  describe "initialize" do
    before do
      @room = HotelGroup::Room.new(1, 200)
    end
    it "returns an instance of class HotelGroup::Room" do
      expect(@room).must_be_kind_of HotelGroup::Room
      expect(@room.number).must_equal 1
      expect(@room.price).must_equal 200
    end

    it "prints out nicely" do
      expect(@room.print_nicely).must_equal "Room 1: $200.00 per night"
    end
  end

  describe "it knows about its own reservations" do
    before do
      @room = HotelGroup::Room.new(1, 400)
      @room2 = HotelGroup::Room.new(2, 400)

      @march2 = Date.new(2019, 3, 2)
      @march3 = Date.new(2019, 3, 3)
      @march4 = Date.new(2019, 3, 4)
      @march5 = Date.new(2019, 3, 5)
      @march6 = Date.new(2019, 3, 6)
      @march7 = Date.new(2019, 3, 7)

      @res = HotelGroup::Reservation.new(1, Date.new(2019, 3, 10), Date.new(2019, 3, 12), @room)
      @res2 = HotelGroup::Reservation.new(1, Date.new(2019, 4, 10), Date.new(2019, 4, 12), @room)
      @res3 = HotelGroup::Reservation.new(2, Date.new(2019, 3, 12), Date.new(2019, 3, 15), @room)

      @date = Date.new(2019, 3, 11)
    end

    it "adds a reservation to its @reservations array" do
      @room.add_reservation(@res)

      expect(@room.reservations.count).must_equal 1
      expect(@room.reservations[0].room.number).must_equal 1
    end

    it "returns true if it is available for a given date range" do
      @room.add_reservation(@res)
      @room.add_reservation(@res2)
      start_to_check = Date.new(2019, 5, 10)
      end_to_check = Date.new(2019, 5, 12)

      expect(@room.is_available?(start_to_check, end_to_check)).must_equal true
    end

    it "returns false if res perfectly overlaps current date range" do
      @room.add_reservation(HotelGroup::Reservation.new(1, @march3, @march6, @room))

      start_to_check = @march3
      end_to_check = @march6

      expect(@room.is_available?(start_to_check, end_to_check)).must_equal false
    end

    it "returns false if res start overlaps current date range" do
      @room.add_reservation(HotelGroup::Reservation.new(1, @march2, @march6, @room))

      start_to_check = @march3
      end_to_check = @march7

      expect(@room.is_available?(start_to_check, end_to_check)).must_equal false
    end

    it "returns false if res end overlaps current date range" do
      @room.add_reservation(HotelGroup::Reservation.new(1, @march2, @march6, @room))

      start_to_check = @march2
      end_to_check = @march5

      expect(@room.is_available?(start_to_check, end_to_check)).must_equal false
    end

    it "returns false if res totally contains current date range" do
      @room.add_reservation(HotelGroup::Reservation.new(1, @march4, @march5, @room))

      start_to_check = @march3
      end_to_check = @march6

      expect(@room.is_available?(start_to_check, end_to_check)).must_equal false
    end

    it "returns false if current date range contains res" do
      @room.add_reservation(HotelGroup::Reservation.new(1, @march4, @march5, @room))

      start_to_check = @march3
      end_to_check = @march6

      expect(@room.is_available?(start_to_check, end_to_check)).must_equal false
    end

    it "raises an error if room is reserved for unavailable dates" do
      @room.add_reservation(@res)
      expect { @room.add_reservation(@res) }.must_raise ArgumentError
    end

    it "allows a reservation to begin on the same day another ends" do
      @room.add_reservation(@res)
      @room.add_reservation(@res3)
    end

    it "allows a reservation to end on the day another begins" do
      @room.add_reservation(HotelGroup::Reservation.new(1, @march3, @march6, @room))

      start_to_check = @march2
      end_to_check = @march2

      expect(@room.is_available?(start_to_check, end_to_check)).must_equal true
    end

    it "has_reservation? returns false if room is unavailable (part of a block) but unreserved" do
      start_time = Date.new(2019, 6, 6)
      end_time = Date.new(2019, 6, 9)
      @room.set_unavailable(start_time, end_time)
      @room.add_reservation(@res)

      expect(@room.has_reservation?(start_time, end_time)).must_equal false
    end

    it "add_block_id adds a block.id to array" do
      start_time = Date.new(2019, 6, 6)
      end_time = Date.new(2019, 6, 9)
      new_block = HotelGroup::HotelBlock.new(1, start_time, end_time, [@room])

      expect(@room.blocks).must_be_kind_of Array
      expect(@room.blocks[0]).must_be_kind_of Integer
    end

    it "is_in_block? returns true if the room is part of a given block" do
      start_time = Date.new(2019, 6, 6)
      end_time = Date.new(2019, 6, 9)
      new_block = HotelGroup::HotelBlock.new(1, start_time, end_time, [@room])

      expect(@room.is_in_block?(new_block)).must_equal true
    end
  end
end
