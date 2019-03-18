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

    expect { block_manager_new.create_block(start_date, end_date, rooms, rate_discount) }.must_raise ArgumentError
  end

  xit "raises ArgumentError if any of the rooms in the block is reserved" do
    reservation_generator

    start_date = Time.parse("2019-03-13 14:08:45 -0700")
    end_date = Time.parse("2019-03-21 14:08:45 -0700")
    rooms = [1, 3, 12, 6, 19]
    rate_discount = 10

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
    expect(block_manager_new.find_by_id(1)).must_be_instance_of Hotel::Block
  end

  it "returns rooms available" do
    block_new

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
      block_new

      expect(block_manager_new.create_reservation_from_block(1, 16)).must_be_instance_of Hotel::Reservation
    end

    it "checks if there are rooms available in the block" do
      block_new

      expect(block_manager_new.create_reservation_from_block(1, 1)).must_be_instance_of Hotel::Reservation
      expect(block_manager_new.rooms_available_in_block(1).length).must_equal 4
      expect(block_manager_new.create_reservation_from_block(1, 16)).must_be_instance_of Hotel::Reservation
      expect(block_manager_new.rooms_available_in_block(1).length).must_equal 3
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
