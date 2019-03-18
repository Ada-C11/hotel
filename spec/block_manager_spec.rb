require_relative "spec_helper"

describe "BlockManager" do
  let(:block_manager_new) do
    Hotel::BlockManager.new
  end

  let (:block_new) do
    start_date = Time.parse("2019-02-24 14:08:45 -0700")
    end_date = Time.parse("2019-02-28 14:08:45 -0700")
    rooms = [1, 4, 6, 16, 19]
    rate_discount = 10
    block = block_manager_new.create_block(start_date, end_date, rooms, rate_discount)
  end

  let(:manager_new) do
    Hotel::ReservationManager.new
  end

  let(:reservation_generator) do
    # Reservation 1
    start_date = Time.parse("2019-03-11 14:08:45 -0700")
    end_date = Time.parse("2019-03-15 14:08:45 -0700")
    room = 3
    manager_new.create_reservation(start_date, end_date, room)
    # Reservation 2
    start_date = Time.parse("2019-03-20 14:08:45 -0700")
    end_date = Time.parse("2019-03-22 14:08:45 -0700")
    room = 20
    manager_new.create_reservation(start_date, end_date, room)
    # Reservation 3
    start_date = Time.parse("2019-02-27 14:08:45 -0700")
    end_date = Time.parse("2019-02-28 14:08:45 -0700")
    room = 12
    manager_new.create_reservation(start_date, end_date, room)
    # Reservation 4
    start_date = Time.parse("2019-03-19 14:08:45 -0700")
    end_date = Time.parse("2019-03-21 14:08:45 -0700")
    room = 6
    manager_new.create_reservation(start_date, end_date, room)
  end

  it "creates a block" do
    expect(block_new).must_be_instance_of Hotel::Block
  end
  it "raises ArgumentError if there are more than 5 rooms in the block" do
    start_date = Time.parse("2019-02-27 14:08:45 -0700")
    end_date = Time.parse("2019-02-28 14:08:45 -0700")
    rooms = [1, 4, 6, 16, 19, 13]
    rate_discount = 10
    expect { block_manager_new.create_block(start_date, end_date, rooms, rate_discount) }.must_raise ArgumentError
  end
  it "raises ArgumentError when range of dates are invalid" do
    start_date = Time.parse("2019-03-19 14:08:45 -0700")
    end_date = Time.parse("2019-03-17 14:08:45 -0700")
    rooms = [1, 4, 6, 16, 19]
    rate_discount = 10
    expect { block_manager_new.create_block(start_date, end_date, rooms, rate_discount) }.must_raise ArgumentError
  end

  it "raises ArgumentError when a room number is invalid" do
    start_date = Time.parse("2019-03-14 14:08:45 -0700")
    end_date = Time.parse("2019-03-17 14:08:45 -0700")
    rooms = [1, 4, 6, 16, 30]
    rate_discount = 10
    # puts "++++++++++#{block_manager_new.create_block(start_date, end_date, rooms, rate_discount)}"
    expect { block_manager_new.create_block(start_date, end_date, rooms, rate_discount) }.must_raise ArgumentError
  end

  xit "raises ArgumentError if any of the rooms in the block is reserved" do
    reservation_generator

    start_date = Time.parse("2019-03-13 14:08:45 -0700")
    end_date = Time.parse("2019-03-21 14:08:45 -0700")
    rooms = [1, 3, 12, 6, 19]
    rate_discount = 10
    # puts "#{block_manager_new.create_block(start_date, end_date, rooms, rate_discount)}"
    expect { block_manager_new.create_block(start_date, end_date, rooms, rate_discount) }.must_raise ArgumentError
  end

  it "raises ArgumentError if rooms in block are in an existing block" do
    block_new

    start_date = Time.parse("2019-02-23 14:08:45 -0700")
    end_date = Time.parse("2019-02-27 14:08:45 -0700")
    rooms = [3, 7, 12, 10, 19]
    rate_discount = 10

    expect { block_manager_new.create_block(start_date, end_date, rooms, rate_discount) }.must_raise ArgumentError
  end

  it "finds a block by id" do
    block_new
    expect(block_manager_new.find_block_by_id(1)).must_be_instance_of Hotel::Block
  end

  it "returns rooms available " do
    block_new
    # puts "#{block_manager_new.rooms_available_in_block(1)}"
    expect(block_manager_new.rooms_available_in_block(1)).must_be_kind_of Array
  end

  it "creates a reservation for a room in the block" do
    start_date = Time.parse("2019-02-24 14:08:45 -0700")
    end_date = Time.parse("2019-02-28 14:08:45 -0700")
    rooms = [1, 4, 6, 16, 19]
    rate_discount = 10
    block = block_manager_new.create_block(start_date, end_date, rooms, rate_discount)

    expect(block_manager_new.create_reservation_from_block(1, 16)).must_be_instance_of Hotel::Reservation
  end
  describe "create reservation from block" do
    let(:block_manager_new) do
      Hotel::BlockManager.new
    end
    let (:block_new) do
      start_date = Time.parse("2019-02-24 14:08:45 -0700")
      end_date = Time.parse("2019-02-28 14:08:45 -0700")
      rooms = [1, 4, 6, 16, 19]
      rate_discount = 10

      block_manager_new.create_block(start_date, end_date, rooms, rate_discount)
    end
    it "creates a reservation for a room in the block" do
      # reservation_generator
      block_new
      expect(block_manager_new.create_reservation_from_block(1, 16)).must_be_instance_of Hotel::Reservation
      # puts "#{block_manager_new.reservations}"
      # puts "@@@@@@@@@#{block_manager_new.find_reservation_by_date(Time.parse("2019-02-24 14:08:45 -0700"), Time.parse("2019-02-28 14:08:45 -0700"))}"
      # expect(block_manager_new.find_reservations_by_block(1)).must_be_kind_of Array
      # expect(manager_new.find_reservation_by_date(Time.parse("2019-02-24 14:08:45 -0700"), Time.parse("2019-02-28 14:08:45 -0700"))).must_be_kind_of Array
    end

    it "checks if there are rooms available in the block" do
      block_new
      expect(block_manager_new.create_reservation_from_block(1, 1)).must_be_instance_of Hotel::Reservation
      expect(block_manager_new.rooms_available_in_block(1).length).must_equal 4
      expect(block_manager_new.create_reservation_from_block(1, 16)).must_be_instance_of Hotel::Reservation
      expect(block_manager_new.rooms_available_in_block(1).length).must_equal 3
      # puts "@@@@@@#{block_manager_new.rooms_available_in_block(1)}"
    end
    it "raises ArgumentError when there are no more rooms available in the block" do
      block_new
      expect(block_manager_new.create_reservation_from_block(1, 1)).must_be_instance_of Hotel::Reservation
      expect(block_manager_new.create_reservation_from_block(1, 4)).must_be_instance_of Hotel::Reservation
      expect(block_manager_new.create_reservation_from_block(1, 6)).must_be_instance_of Hotel::Reservation
      expect(block_manager_new.create_reservation_from_block(1, 16)).must_be_instance_of Hotel::Reservation
      expect(block_manager_new.create_reservation_from_block(1, 19)).must_be_instance_of Hotel::Reservation
      expect { block_manager_new.create_reservation_from_block(1, 19) }.must_raise ArgumentError
    end
  end
end

# As a user of the hotel system,
# I can create a Hotel Block if I give a date range, collection of rooms, and a discounted room rate
#       Create method create_block (start_date, end_date, rooms, rate_discount) OK
#       check there are no more than 5 rooms in the block to create OK
#       check if the dates for the block are valid OK
#       create an ID from blocks array

## I MIGHT WANT TO CREATE A BLOCK MANAGER
# I want an exception raised if I try to create a Hotel
# Block and at least one of the rooms is unavailable for
# the given date range --> Might be able to inherit this funtionality
# from reseervation manager
#       Check reservations when creating a block, if any of the rooms
#       in the block I'm creating is reserved raise ArgumentError

# Given a specific date, and that a room is set aside in a
# hotel block for that specific date, I cannot reserve that
# specific room for that specific date, because it is unavailable
# --> if I do inheritance all of these are going to be awkward... ??
#      Check blocks when creating a new reservation, if the room is
#      in one of the blocks don't allow reservation (raise ArgumentError?)

# Given a specific date, and that a room is set aside in a hotel
# block for that specific date, I cannot create another hotel
# block that includes that specific room for that specific date,
# because it is unavailable
#       Check blocks when creating a new block, if any of the rooms
#       in the block I'm creating is in another block (raise ArgumentError?) OK

# I can check whether a given block has any rooms available
#       Check a specific block by (id?) return a list of available rooms

# I can reserve a specific room from a hotel block
#       create a new reservation with one of the rooms in the list returned in last step

# I can only reserve that room from a hotel block for
# the full duration of the block
#       create a new reservation with the same start and end dates of the block

# I can see a reservation made from a hotel block from
# the list of reservations for that date (see wave 1 requirements)
#       when reserving from a block make sure that the reservation is stored within the
#       reservations and it's displayed when checking reseervations for a date range
#       in reservations manager

# Details
# A block can contain a maximum of 5 rooms OK
# When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
# All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations
