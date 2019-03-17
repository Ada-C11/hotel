require_relative "spec_helper"

require "awesome_print"

describe "Reservation_manager instantiation" do
  it "is an instance of Reservation Manager" do
    manager = Hotel::ReservationManager.new
    expect(manager).must_be_kind_of Hotel::ReservationManager
  end
end

describe "all_rooms method" do
  it "can list all rooms in the hotel" do
    rooms = Hotel::ReservationManager.new
    expect(rooms.all_rooms.length).must_equal 20
  end
end

describe "make_reservation method" do
  let (:manager) {
    Hotel::ReservationManager.new
  }
  it "can make a new reservation" do
    new_reservation = manager.make_reservation("march 15, 2019", "march 20, 2019")
    # expect(new_reservation.room_number).must_equal 6
  end

  it "raises an ArgumentError when there are no available rooms" do
    expect {
      (Hotel::ReservationManager::MAX_ROOMS + 1).times do
        manager.make_reservation("march 15, 2019", "march 20, 2019")
      end
    }.must_raise ArgumentError
  end
end

describe "reservations_by_date method" do
  let (:manager) {
    Hotel::ReservationManager.new
  }

  it "can list all the reservations for a specified date range" do
    reservation1 = manager.make_reservation("march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation("march 17, 2019", "march 22, 2019")
    start_date = "march 14, 2019"
    end_date = "march 16, 2019"
    list_reservations = manager.reservations_by_date(start_date, end_date)
    ap list_reservations

    expect(list_reservations.length).must_equal 1
  end

  it "returns an empty array when there are no reservations for a specified date range" do
    reservation1 = manager.make_reservation("march 15, 2019", "march 20, 2019")
    reservation2 = manager.make_reservation("march 17, 2019", "march 22, 2019")
    start_date = "April 1, 2019"
    end_date = "April 7, 2019"
    list_reservations = manager.reservations_by_date(start_date, end_date)
    expect(list_reservations).must_be_empty
  end
end

describe "available_rooms method" do
  let (:manager) {
    Hotel::ReservationManager.new
  }
  let (:reservation1) {
    manager.make_reservation("march 15, 2019", "march 20, 2019")
  }
  let (:reservation2) {
    manager.make_reservation("march 17, 2019", "march 22, 2019")
  }
  let (:block1) {
    manager.make_block(5, "march 19, 2019", "march 23, 2019", 1)
  }
  let (:block2) {
    manager.make_block(4, "march 21, 2019", "march 25, 2019", 2)
  }

  it "can return available rooms for a specified date range, end_date overlap" do
    reservation1
    reservation2
    block1
    block2
    start_date = "march 14, 2019"
    end_date = "march 20, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms.length).must_equal 13
  end

  it "can return available rooms for a specified date range, full range unavail" do
    reservation1
    reservation2
    block1

    start_date = "march 17, 2019"
    end_date = "march 20, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms.length).must_equal 13
  end

  it "can return available rooms for a specified date range, start_date unavail" do
    reservation1
    reservation2
    block1
    block2

    start_date = "march 20, 2019"
    end_date = "march 25, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms.length).must_equal 10
  end

  it "can return an empty array when no rooms are available for a specified date range" do
    Hotel::ReservationManager::MAX_ROOMS.times do
      manager.make_reservation("march 15, 2019", "march 20, 2019")
    end

    start_date = "march 15, 2019"
    end_date = "march 16, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms).must_be_empty
  end

  it "includes all rooms if no reservations" do
    start_date = "march 14, 2019"
    end_date = "march 16, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms.length).must_equal 20
  end

  it "does not include the booked rooms" do
    reservation1
    reservation2
    start_date = "march 14, 2019"
    end_date = "march 16, 2019"
    vacant_rooms = manager.available_rooms(start_date, end_date)
    expect(vacant_rooms).wont_include reservation1.room_number
    expect(vacant_rooms).must_include reservation2.room_number
  end
end

describe "make_block method" do
  let (:manager) {
    Hotel::ReservationManager.new
  }
  let (:reservation1) {
    manager.make_reservation("march 15, 2019", "march 20, 2019")
  }
  let (:reservation2) {
    manager.make_reservation("march 17, 2019", "march 22, 2019")
  }
  it "Can reserve a block of 5 rooms from available rooms" do
    reservation1
    reservation2
    new_block = manager.make_block(5, "march 15, 2019", "march 20, 2019", 1)
    # ap new_block
    expect(new_block.length).must_equal 5
    expect(new_block).wont_include reservation1.room_number
    expect(new_block).wont_include reservation2.room_number
  end

  it "Will not show blocked rooms as available" do
    reservation1
    reservation2
    manager.make_block(4, "march 19, 2019", "march 23, 2019", 1)

    vacant_rooms = manager.available_rooms("march 19, 2019", "march 20, 2019")
    expect(vacant_rooms.length).must_equal 14
    # expect(vacant_rooms).wont_include reserved_block_rooms
    expect(vacant_rooms).wont_include reservation1.room_number
    expect(vacant_rooms).wont_include reservation2.room_number
  end

  it "Raises and argument error for room blocks with more than 5 rooms" do
    expect { manager.make_block(6, "march 19, 2019", "march 23, 2019", 1) }.must_raise ArgumentError
  end
end

describe "check_block_availability method" do
  let (:manager) {
    Hotel::ReservationManager.new
  }
  let (:block1) {
    manager.make_block(5, "march 19, 2019", "march 23, 2019", 1)
  }

  it "Will show rooms still available in a specified block" do
    block1
    id = 1
    avail_rooms = manager.check_block_availability(id)
    expect(avail_rooms.length).must_equal 5
  end

  it "Will not show rooms that have been turned into reservations" do
    block1
    id = 1
    reserved_room = manager.reserve_block_room(id)
    avail_rooms = manager.check_block_availability(id)
    expect(avail_rooms.length).must_equal 4
  end
end

describe "reserve_block_room method" do
  let (:manager) {
    Hotel::ReservationManager.new
  }
  let (:block1) {
    manager.make_block(5, "march 19, 2019", "march 23, 2019", 1)
  }
  let (:reservation2) {
    manager.make_reservation("march 17, 2019", "march 22, 2019")
  }

  it "can reserve a room in a specified block by moving to @reservations and removing it from @block" do
    block1
    id = 1
    reserved_room = manager.reserve_block_room(id)
    expect(reserved_room.length).must_equal 1
    expect(reserved_room[0].block_id).must_equal 1
    expect(block1.length).must_equal 4
  end

  it "Will show the reserved room from the block in @reservations for that specific date range" do
    block1
    reservation2
    id = 1
    start_date = "march 18, 2019"
    end_date = "march 20, 2019"
    reserved_room = manager.reserve_block_room(id)
    all_reservations = manager.reservations_by_date(start_date, end_date)
    expect(all_reservations.length).must_equal 2
  end
end
