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

    # it "accurately connects reservations with rooms" do
    #   reservation_manager.reservations.each do |reservation|
    #     expect(reservation.room).wont_be_nil
    #     expect(reservation.room.room_id).must_equal reservation.room_id
    #     expect(reservation.room.reservations).must_include room
    #   end
    # end
  end

  describe "reserve method" do
    let(:new_reservation) {
      reservation_manager.reserve(room_id: 1,
                                  check_in_date: "2019-03-12",
                                  check_out_date: "2019-03-15")
    }
    it "can reserve an available room and adds a new reservation to the list of reservations" do
      before_reserve = reservation_manager.reservations.length
      new_reservation
      after_reserve = reservation_manager.reservations.length
      expect(after_reserve - before_reserve).must_equal 1
    end

    it "cannot reserve unavailable rooms" do
      new_reservation
      expect { reservation_manager.reserve(new_reservation) }.must_raise ArgumentError
    end
  end
  # will refactor
  describe "list_reservations method" do
    it "returns an array" do
      reservation_manager.reserve(room_id: 1,
                                  check_in_date: "2019-03-12",
                                  check_out_date: "2019-03-15")
      reservation_manager.reserve(room_id: 2,
                                  check_in_date: "2019-03-12",
                                  check_out_date: "2019-03-15")
      expect(reservation_manager.list_reservations(date: "2019-03-14")).must_be_kind_of Array
    end

    it "lists the right reservations with the given date " do
      reservation_manager.reserve(room_id: 1,
                                  check_in_date: "2019-03-12",
                                  check_out_date: "2019-03-15")
      reservation_manager.reserve(room_id: 2,
                                  check_in_date: "2019-03-12",
                                  check_out_date: "2019-03-15")
      reservation_manager.reserve(room_id: 2,
                                  check_in_date: "2019-04-12",
                                  check_out_date: "2019-04-15")
      expect(reservation_manager.list_reservations(date: "2019-03-14").length).must_equal 2
      expect(reservation_manager.list_reservations(date: "2019-04-14").length).must_equal 1
    end
  end

  describe "find_available_rooms" do
    let(:reserve_03_10_03_15) { reservation_manager.reserve(room_id: 1, check_in_date: "2019-03-10", check_out_date: "2019-03-15") }
    let(:reserve_03_17_03_20) { reservation_manager.reserve(room_id: 1, check_in_date: "2019-03-17", check_out_date: "2019-03-20") }
    let(:reserve_04_15_04_20) { reservation_manager.reserve(room_id: 2, check_in_date: "2019-04-15", check_out_date: "2019-04-20") }

    it "returns the right number of rooms given a date range" do
      reserve_03_10_03_15
      reserve_03_17_03_20
      reserve_04_15_04_20
      expect(reservation_manager.find_available_rooms(check_in_date: "2019-03-20", check_out_date: "2019-03-22").length).must_equal 20
      expect(reservation_manager.find_available_rooms(check_in_date: "2019-04-17", check_out_date: "2019-04-19").length).must_equal 19
      expect(reservation_manager.find_available_rooms(check_in_date: "2019-03-10", check_out_date: "2019-04-19").length).must_equal 18
    end

    it "returns all the rooms if no room has been reserved" do
      expect(reservation_manager.find_available_rooms(check_in_date: "2019-03-20", check_out_date: "2019-03-22").length).must_equal 20
    end

    it "returns 0 if all rooms have been reserved" do
      reservation_manager.rooms.length.times do |i|
        reservation_manager.reserve(room_id: i + 1,
                                    check_in_date: "2019-03-10",
                                    check_out_date: "2019-03-15")
      end

      expect(reservation_manager.find_available_rooms(check_in_date: "2019-03-11", check_out_date: "2019-03-14").length).must_equal 0
    end

    it "returns the right number of rooms when check_in_date is the same as the reserved check_out_date " do
      reserve_03_17_03_20
      expect(reservation_manager.find_available_rooms(check_in_date: "2019-03-20", check_out_date: "2019-03-22").length).must_equal 20
    end

    it "returns the right number of rooms when both check_in_date and check_out_date are within the reserved rate range " do
      reserve_03_10_03_15
      expect(reservation_manager.find_available_rooms(check_in_date: "2019-03-12", check_out_date: "2019-03-12").length).must_equal 19
    end

    it "returns the right number of rooms when check_out_date is within the reserved rate range " do
      reserve_03_10_03_15
      expect(reservation_manager.find_available_rooms(check_in_date: "2019-03-09", check_out_date: "2019-03-11").length).must_equal 19
    end

    it "returns the right number of rooms when check_in_date is within the reserved rate range " do
      reserve_03_10_03_15
      expect(reservation_manager.find_available_rooms(check_in_date: "2019-03-14", check_out_date: "2019-03-17").length).must_equal 19
    end

    it "returns the right number of rooms when check_in_date and check_in_date range contains reserved rate range " do
      reserve_03_10_03_15
      reserve_03_17_03_20
      expect(reservation_manager.find_available_rooms(check_in_date: "2019-03-08", check_out_date: "2019-03-22").length).must_equal 19
    end

    it "returns the right number of rooms when check_in_date and check_out_date range is within reserved rate range " do
      reserve_03_10_03_15
      expect(reservation_manager.find_available_rooms(check_in_date: "2019-03-12", check_out_date: "2019-03-14").length).must_equal 19
    end

    it "cannot reserve a room set in the block" do
      reservation_manager.create_block(room_ids: [1, 2, 3],
                                       check_in_date: "2019-03-10",
                                       check_out_date: "2019-03-15",
                                       discount_rate: 0.10)
      expect { reserve_03_10_03_15 }.must_raise ArgumentError
    end
  end

  describe "create_block method" do
    it "raises ArgumentError if at least one of the rooms is unavailable" do
      reservation_manager.reserve(room_id: 1, check_in_date: "2019-03-10", check_out_date: "2019-03-15")
      expect {
        reservation_manager.create_block(room_ids: [1, 2, 3],
                                         check_in_date: "2019-03-10",
                                         check_out_date: "2019-03-15",
                                         discount_rate: 0.10)
      }.must_raise ArgumentError
    end

    it "adds to the collection of blocks" do
      before_block = reservation_manager.blocks.length
      reservation_manager.create_block(room_ids: [2, 3],
                                       check_in_date: "2019-03-10",
                                       check_out_date: "2019-03-15",
                                       discount_rate: 0.10)
      after_block = reservation_manager.blocks.length
      expect(after_block - before_block).must_equal 1
    end

    it "cannot create a hotel block for a room already set in another block" do
      reservation_manager.create_block(room_ids: [2, 3],
                                       check_in_date: "2019-03-10",
                                       check_out_date: "2019-03-15",
                                       discount_rate: 0.10)
      expect {
        reservation_manager.create_block(room_ids: [3],
                                         check_in_date: "2019-03-10",
                                         check_out_date: "2019-03-15",
                                         discount_rate: 0.10)
      }.must_raise ArgumentError
    end
  end

  describe "check_rooms_in_blocks" do
    it "can check room availabity in a given block" do
      reservation_manager.create_block(room_ids: [2, 3],
                                       check_in_date: "2019-03-10",
                                       check_out_date: "2019-03-15",
                                       discount_rate: 0.10)
      expect(reservation_manager.check_rooms_in_blocks(1).length).must_equal 2
    end

    it "raises ArgumentError if no block is found" do
      expect { reservation_manager.check_rooms_in_blocks(1) }.must_raise ArgumentError
    end
  end

  describe "reserve_from_block" do
    it "can reserve from the block" do
      reservation_manager.create_block(room_ids: [1, 2, 3],
                                       check_in_date: "2019-03-10",
                                       check_out_date: "2019-03-15",
                                       discount_rate: 0.10)
      before_reserve = reservation_manager.reservations.length
      reservation_manager.reserve_from_block(room_id: 1, block_id: 1)
      after_reserve = reservation_manager.reservations.length
      expect(after_reserve - before_reserve).must_equal 1
    end
  end
  # might remove?
  # describe "find_room method" do
  #   it "can find an instance of Room" do
  #     expect(reservation_manager.find_room(1)).must_be_instance_of Hotel::Room
  #   end

  #   it "throws an ArgumentError for a bad room_id" do
  #     expect { reservation_manager.find_room(0) }.must_raise ArgumentError
  #     expect { reservation_manager.find_room(21) }.must_raise ArgumentError
  #     expect { reservation_manager.find_room(nil) }.must_raise ArgumentError
  #   end
  # end

  describe "validate date method" do
    it "raises an ArgumentError if date is not a string" do
      expect { Hotel::ReservationManager.validate_date(2019 - 03 - 12) }.must_raise ArgumentError
    end

    it "raises an ArgumentError if the date is not the right format" do
      expect { Hotel::ReservationManager.validate_date("03/12/2019") }.must_raise ArgumentError
    end

    it "raises an ArgumentError if the date is nil" do
      expect { Hotel::ReservationManager.validate_date(nil) }.must_raise ArgumentError
    end

    it "raises an ArgumentError if month is larger than 12" do
      expect { Hotel::ReservationManager.validate_date("2019-13-12") }.must_raise ArgumentError
    end

    it "raises an ArgumentError if day is larger than 31" do
      expect { Hotel::ReservationManager.validate_date("2019-03-32") }.must_raise ArgumentError
    end
  end

  describe "validate date range method" do
    it "raises an Argument Error if the check_out_date is before the check_in_date" do
      expect { Hotel::ReservationManager.validate_date_range("2019-03-10", "2019-03-09") }.must_raise ArgumentError
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
