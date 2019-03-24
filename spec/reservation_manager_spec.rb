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
      [:rooms, :reservations, :blocks].each do |prop|
        expect(reservation_manager).must_respond_to prop
      end

      expect(reservation_manager.rooms).must_be_kind_of Array
      expect(reservation_manager.reservations).must_be_kind_of Array
      expect(reservation_manager.blocks).must_be_kind_of Array
    end

    it "has 20 rooms" do
      expect(reservation_manager.rooms.length).must_equal 20
    end
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

    it "cannot reserve a room set in the block" do
      reservation_manager.create_block(room_ids: [1, 2, 3],
                                       check_in_date: "2019-03-10",
                                       check_out_date: "2019-03-15",
                                       discount_rate: 0.10)
      expect {
        reservation_manager.reserve(room_id: 1,
                                    check_in_date: "2019-03-12",
                                    check_out_date: "2019-03-14")
      }.must_raise ArgumentError
    end
  end

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

    it "lists the right number of reservations with the given date " do
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

  describe "total_cost method" do
    it "correctly calculates the cost for a given reservation" do
      reservation_manager.reserve(room_id: 1, check_in_date: "2019-03-10", check_out_date: "2019-03-15")
      expect(reservation_manager.total_cost(reservation_id: 1)).must_be_close_to 1000.0
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

  describe "check_available_rooms_in_blocks" do
    it "can get available rooms in a given block" do
      reservation_manager.create_block(room_ids: [1, 2, 3],
                                       check_in_date: "2019-03-10",
                                       check_out_date: "2019-03-15",
                                       discount_rate: 0.10)
      expect(reservation_manager.check_available_rooms_in_blocks(block_id: 1).length).must_equal 3
    end

    it "returns an empty array if no room is available in a block" do
      reservation_manager.create_block(room_ids: [2, 3],
                                       check_in_date: "2019-03-10",
                                       check_out_date: "2019-03-15",
                                       discount_rate: 0.10)

      reservation_manager.reserve_from_block(room_id: 2, block_id: 1)
      reservation_manager.reserve_from_block(room_id: 3, block_id: 1)
      expect(reservation_manager.check_available_rooms_in_blocks(block_id: 1).length).must_equal 0
    end

    it "raises ArgumentError if no block is found" do
      expect { reservation_manager.check_available_rooms_in_blocks(1) }.must_raise ArgumentError
    end
  end

  describe "reserve_from_block" do
    it "adds to the reservation list after reserving from the block" do
      reservation_manager.create_block(room_ids: [1, 2, 3],
                                       check_in_date: "2019-03-10",
                                       check_out_date: "2019-03-15",
                                       discount_rate: 0.10)
      before_reserve = reservation_manager.reservations.length
      reservation_manager.reserve_from_block(room_id: 1, block_id: 1)
      after_reserve = reservation_manager.reservations.length
      expect(after_reserve - before_reserve).must_equal 1
    end

    it "changes the room's status in the block to unavailable after the room has been reserved from the block" do
      reservation_manager.create_block(room_ids: [1, 2, 3],
                                       check_in_date: "2019-03-10",
                                       check_out_date: "2019-03-15",
                                       discount_rate: 0.10)
      reservation_manager.reserve_from_block(room_id: 1, block_id: 1)
      block = reservation_manager.blocks.find { |block| block.block_id == 1 }
      room_status = block.rooms_info.each do |current_room_id, status|
        return status if current_room_id == 1
      end
      expect(room_status).must_equal :UNAVAILABLE
    end
  end

  describe "validate_id method" do
    it "raises ArgumentError if id is smaller than 0 or is not an Integer" do
      expect { Hotel::ReservationManager.validate_id(-1) }.must_raise ArgumentError
      expect { Hotel::ReservationManager.validate_id() }.must_raise ArgumentError
      expect { Hotel::ReservationManager.validate_id("string") }.must_raise ArgumentError
    end
  end

  describe "set_room_rate method" do
    it "allows the ability to set different rates for different rooms" do
      reservation_manager.set_room_rate(room_id: 1, room_rate: 300.00)
      room = reservation_manager.rooms.find { |room| room.room_id == 1 }
      expect(room.cost).must_equal 300.00
    end
  end
end
