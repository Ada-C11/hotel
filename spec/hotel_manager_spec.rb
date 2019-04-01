require_relative "spec_helper"

describe "Hotel_manager class" do
  before do
    @hotel_manager = Hotel::HotelManager.new(Hotel::Room.make_rooms_standard)
    @hotel_manager.make_reservation(1, "2019-3-15", "2019-3-20")
    @hotel_manager.make_reservation(2, "2019-3-15", "2019-3-18")
  end

  describe "Hotel_manager instantiation" do
    it "is an istanceof a Hotel_manager" do
      expect(@hotel_manager).must_be_kind_of Hotel::HotelManager
    end

    it "has an array of 20 rooms" do
      expect(@hotel_manager.rooms.length).must_equal 20
    end
  end

  describe "room methods in HotelManager" do
    describe "access available rooms" do
      it "returns an array with the available rooms" do
        avail_rooms = @hotel_manager.list_available_rooms("2019-3-15", "2019-3-20")

        expect(avail_rooms).must_be_kind_of Array
        expect(avail_rooms.length).must_equal 18
      end

      it "returns an empty array in there are no rooms" do
        18.times do |i|
          @hotel_manager.make_reservation(i + 3, "2019-3-15", "2019-3-20")
        end
        avail_rooms = @hotel_manager.list_available_rooms("2019-3-15", "2019-3-20")

        expect(avail_rooms.length).must_equal 0
      end
    end
  end

  describe "reservation methods in HotelManager" do
    describe "access reservations by date" do
      it "returns an array with the correct number of reservations" do
        reservations = @hotel_manager.list_reservations_by_date("2019-3-15")

        expect(reservations).must_be_kind_of Array
        expect(reservations.length).must_equal 2
      end

      it "doesn't include reservations where the end date is the date" do
        reservations = @hotel_manager.list_reservations_by_date("2019-3-20")

        expect(reservations.length).must_equal 0
      end

      it "includes reservations where the date is between the start and end date" do
        reservations = @hotel_manager.list_reservations_by_date("2019-3-19")

        expect(reservations.length).must_equal 1
      end
    end

    describe "make reservation" do
      it "makes a reservation and adds to Reservations array if given valid args" do
        before_reservation = @hotel_manager.reservations.length
        @hotel_manager.make_reservation(3, "2019-3-15", "2019-3-20")
        after_reservation = @hotel_manager.reservations.length

        expect(after_reservation - 1).must_equal before_reservation
      end

      it "raises an argument if the room is unavailable during given dates" do
        expect { @hotel_manager.make_reservation(2, "2019-3-15", "2019-3-18") }.must_raise ArgumentError
      end

      it "raises an argument if the dates are not valid" do
        expect { @hotel_manager.make_reservation(3, "2019-3-15", "2019-3-15") }
      end
    end
  end

  describe "block methods in HotelManager" do
    describe "make block" do
      it "creates a block, updates the blocks array, affects available rooms" do
        new_block = @hotel_manager.make_block([3, 4, 5, 6], "2019-3-15", "2019-3-20", 175)
        avail_rooms = @hotel_manager.list_available_rooms("2019-3-15", "2019-3-20")

        expect(new_block).must_be_kind_of Hotel::Block
        expect(@hotel_manager.blocks.length).must_equal 1
        expect(avail_rooms.length).must_equal 14
      end

      it "raises an exception if an unavailable room is part of the block" do
        expect { @hotel_manager.make_block([2, 3, 4, 5, 6], "2019-3-15", "2019-3-20", 175) }.must_raise ArgumentError
      end

      it "raises an exception if more than 5 rooms are supplied" do
        expect { @hotel_manager.make_block([3, 4, 5, 6, 7, 8], "2019-3-15", "2019-3-20", 175) }.must_raise ArgumentError
      end

      it "raises an exception if start date is after end date" do
        expect { @hotel_manager.make_block([3, 4, 5, 6], "2019-3-15", "2019-3-14", 175) }.must_raise ArgumentError
      end
    end

    describe "reserve from block" do
      before do
        @new_block = @hotel_manager.make_block([3, 4, 5, 6], "2019-3-15", "2019-3-20", 175)
      end

      it "updates reservations array when room is reserved from block" do
        new_reservation = @hotel_manager.reserve_from_block(@new_block, 3)

        expect(@hotel_manager.reservations.last).must_equal new_reservation
      end

      it "raises an exception if the room is not a part of the block" do
        expect { @hotel_manager.reserve_from_block(@new_block, 7) }.must_raise ArgumentError
      end

      it "raises an exception if the room has already been booked" do
        @hotel_manager.reserve_from_block(@new_block, 3)

        expect { @hotel_manager.reserve_from_block(@new_block, 3) }.must_raise ArgumentError
      end
    end
  end
end
