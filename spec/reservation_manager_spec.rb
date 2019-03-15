require_relative "spec_helper"

describe "ReservationManager" do
  let(:reservation_manager) {
    Hotel::ReservationManager.new
  }
  describe "initialize" do
    it "can be instantiated" do
      expect(reservation_manager).must_be_kind_of Hotel::ReservationManager
    end

    it "establishes the base structures when instantiated" do
      [:rooms, :reservations].each do |prop|
        expect(reservation_manager).must_respond_to prop
      end

      expect(reservation_manager.rooms).must_be_kind_of Array
      expect(reservation_manager.reservations).must_be_kind_of Array
    end

    it "has 20 rooms" do
      expect(reservation_manager.rooms.length).must_equal 20
    end

    it "accurately connects reservations with rooms" do
      reservation_manager.reservations.each do |reservation|
        expect(reservation.room).wont_be_nil
        expect(reservation.room.room_id).must_equal reservation.room_id
        expect(reservation.room.reservations).must_include room
      end
    end
  end

  describe "reserve method" do
    # reserved_room = Hotel::Room.new(1)

    it "add a new reservation to the list of reservations" do
      before_reserve = reservation_manager.reservations.length
      reservation_manager.reserve(1, "2019-03-12", "2019-03-15")
      after_reserve = reservation_manager.reservations.length
      expect(after_reserve - before_reserve).must_equal 1
    end

    it "raises an ArgumentError if date is not a string" do
      expect { reservation_manager.reserve(1, 2019 - 03 - 12, "2019-03-15") }.must_raise ArgumentError
    end

    it "raises an ArgumentError if the date is not the right format" do
      expect { reservation_manager.reserve(1, "03/12/2019", "03/12/2019") }.must_raise ArgumentError
    end

    it "raises an ArgumentError if the date is nil" do
      expect { reservation_manager.reserve(1, nil, "2019-03-15") }.must_raise ArgumentError
      expect { reservation_manager.reserve(1, "2019-03-15", nil) }.must_raise ArgumentError
    end

    it "raises an ArgumentError if month is larger than 12" do
      expect { reservation_manager.reserve(1, "2019-13-12", "2019-03-15") }.must_raise ArgumentError
    end

    it "raises an ArgumentError if day is larger than 31" do
      expect { reservation_manager.reserve(1, "2019-03-32", "2019-03-15") }.must_raise ArgumentError
    end

    it "raises an ArgumentEorr if check_out_date is before check_in_date" do
      expect { reservation_manager.reserve(1, "2019-03-18", "2019-03-15") }.must_raise ArgumentError
    end
  end

  describe "list_reservations method" do
    it "lists all reservations with the right date " do
      room1 = Hotel::Room.new(1)
      room2 = Hotel::Room.new(2)
      reservation_manager.reserve(room1, "2019-03-12", "2019-03-15")
      reservation_manager.reserve(room2, "2019-03-12", "2019-03-15")
      reservation_manager.reserve(room1, "2019-04-12", "2019-04-15")
      expect(reservation_manager.list_reservations("2019-03-14")).must_be_kind_of Array
      expect(reservation_manager.list_reservations("2019-03-14").length).must_equal 2
      expect(reservation_manager.list_reservations("2019-04-14").length).must_equal 1
    end

    it "raises an ArgumentError if date is not a string" do
      expect { reservation_manager.list_reservations(2019 - 03 - 13) }.must_raise ArgumentError
    end

    it "raises an ArgumentError if the date is not the right format" do
      expect { reservation_manager.list_reservations("03/13/2019") }.must_raise ArgumentError
    end

    it "raises an ArgumentError if the date is nil" do
      expect { reservation_manager.list_reservations(nil) }.must_raise ArgumentError
    end

    it "raises an ArgumentError if month is larger than 12" do
      expect { reservation_manager.list_reservations("2019-13-14") }.must_raise ArgumentError
    end

    it "raises an ArgumentError if day is larger than 31" do
      expect { reservation_manager.list_reservations("2019-03-32") }.must_raise ArgumentError
    end
  end

  describe "find_available_rooms" do
    it "returns the right list of available rooms given a date range" do
      reservation_manager.reserve(1, "2019-03-10", "2019-03-15")
      reservation_manager.reserve(1, "2019-03-17", "2019-03-20")
      reservation_manager.reserve(2, "2019-04-15", "2019-04-20")

      expect(reservation_manager.find_available_rooms("2019-03-12", "2019-03-12").length).must_equal 19
      expect(reservation_manager.find_available_rooms("2019-03-09", "2019-03-11").length).must_equal 19
      expect(reservation_manager.find_available_rooms("2019-03-14", "2019-03-17").length).must_equal 19
      expect(reservation_manager.find_available_rooms("2019-03-08", "2019-03-22").length).must_equal 19
      expect(reservation_manager.find_available_rooms("2019-03-12", "2019-03-14").length).must_equal 19
      expect(reservation_manager.find_available_rooms("2019-03-20", "2019-03-22").length).must_equal 20
    end
  end

  describe "find_room method" do
    it "can find an instance of Room" do
      expect(reservation_manager.find_room(1)).must_be_instance_of Hotel::Room
    end

    it "throws an ArgumentError for a bad room_id" do
      expect { reservation_manager.find_room(0) }.must_raise ArgumentError
      expect { reservation_manager.find_room(21) }.must_raise ArgumentError
      expect { reservation_manager.find_room(nil) }.must_raise ArgumentError
    end
  end

  # describe "connect_reservations" do
  #   it "can connect reservations with the room/s" do
  #     room1 = Hotel::Room.new(1)
  #     room2 = Hotel::Room.new(2)
  #     reservation_manager.reserve(room1, "2019-03-12", "2019-03-15")
  #     reservation_manager.reserve(room2, "2019-04-12", "2019-04-15")
  #     reservation_manager.connect_reservations

  #     reservation_manager.reservations.each do |reservation|
  #       expect(reservation.room).wont_be_nil
  #       expect(reservation.room.room_id).must_equal reservation.room_id
  #       expect(reservation.room.reservations).must_include room
  #     end
  #   end
  # end
end
