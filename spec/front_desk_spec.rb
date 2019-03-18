require_relative "spec_helper"

describe "FrontDesk class" do
  let(:frontdesk) { Hotel::FrontDesk.new }

  describe "Initialization" do
    it "is able to instantiate" do
      expect(frontdesk).must_be_kind_of Hotel::FrontDesk
    end

    it "can generate list of rooms" do
      expect(frontdesk.rooms).must_be_kind_of Array

      # Can I set this to be NUMBER_OF_ROOMS constant?
      expect(frontdesk.rooms.length).must_equal 20

      expect(frontdesk.rooms[0]).must_be_kind_of Hotel::Room
    end

    it "creates an empty array of reservations" do
      expect(frontdesk.reservations).must_be_kind_of Array
      expect(frontdesk.reservations.length).must_equal 0
    end
  end

  describe "Reserve" do
    it "can reserve a room for given date range" do
      res = frontdesk.reserve_room(check_in: "feb5", check_out: "feb7")
      expect(res).must_be_kind_of Hotel::Reservation
    end

    it "reserves first available room" do
      res = frontdesk.reserve_room(check_in: "feb5", check_out: "feb7")
      expect(res.room.number).must_equal 1
    end

    it "can reserve a room for a date range that's before another reservation" do
      frontdesk.reserve_room(check_in: "feb5", check_out: "feb7")
      expect(frontdesk.reserve_room(check_in: "feb2", check_out: "feb4")).must_be_kind_of Hotel::Reservation
    end

    it "can reserve a room for a date range that's after another reservation" do
      frontdesk.reserve_room(check_in: "feb2", check_out: "feb4")
      expect(frontdesk.reserve_room(check_in: "feb5", check_out: "feb7")).must_be_kind_of Hotel::Reservation
    end

    it "can reserve a room for a check-in that begins on another reservation's check-out date" do
      frontdesk.reserve_room(check_in: "feb2", check_out: "feb4")
      expect(frontdesk.reserve_room(check_in: "feb4", check_out: "feb7")).must_be_kind_of Hotel::Reservation
    end

    it "can reserve a room for a check-in that ends on another reservation's check-in date" do
      frontdesk.reserve_room(check_in: "feb2", check_out: "feb4")
      expect(frontdesk.reserve_room(check_in: "feb1", check_out: "feb2")).must_be_kind_of Hotel::Reservation
    end

    it "raises an ArgumentError if date range is invalid" do
      expect { frontdesk.reserve_room(check_in: "feb5", check_out: "feb3") }.must_raise ArgumentError
    end

    it "raises an AvailabilityError if no room is available for date range" do
      20.times do
        frontdesk.reserve_room(check_in: "feb9", check_out: "feb10")
      end
      expect { frontdesk.reserve_room(check_in: "feb9", check_out: "feb10") }.must_raise AvailabilityError
    end

    it "raises an AvailabilityError if room is requested for same dates" do
      frontdesk.reserve_room(check_in: "feb3", check_out: "feb5", room_number: 7)
      expect { frontdesk.reserve_room(check_in: "feb3", check_out: "feb5", room_number: 7) }.must_raise AvailabilityError
    end

    it "raises an AvailabilityError if room is requested for dates that overlap in the front" do
      frontdesk.reserve_room(check_in: "feb3", check_out: "feb4", room_number: 7)
      expect { frontdesk.reserve_room(check_in: "feb3", check_out: "feb5", room_number: 7) }.must_raise AvailabilityError
    end

    it "raises an AvailabilityError if room is requested for dates that overlap in the back" do
      frontdesk.reserve_room(check_in: "feb3", check_out: "feb5", room_number: 7)
      expect { frontdesk.reserve_room(check_in: "feb4", check_out: "feb5", room_number: 7) }.must_raise AvailabilityError
    end

    it "raises an AvailabilityError if room is requested for a range that is contained by another reservation" do
      frontdesk.reserve_room(check_in: "feb3", check_out: "feb6", room_number: 7)
      expect { frontdesk.reserve_room(check_in: "feb4", check_out: "feb5", room_number: 7) }.must_raise AvailabilityError
    end

    it "raises an AvailabilityError if room is requested for a range that is containing another reservation" do
      frontdesk.reserve_room(check_in: "feb3", check_out: "feb6", room_number: 7)
      expect { frontdesk.reserve_room(check_in: "feb2", check_out: "feb7", room_number: 7) }.must_raise AvailabilityError
    end
  end

  describe "Assign room" do
    it "can assign an available room" do
      fd = Hotel::FrontDesk.new
      res = fd.reserve_room(check_in: "feb3", check_out: "feb5")
      expect(res.room).must_be_kind_of Hotel::Room
      expect(res.room.number).must_equal 1
      res2 = fd.reserve_room(check_in: "feb3", check_out: "feb5") # another reservation on the same nights
      expect(res2.room.number).must_equal 2
    end
  end

  describe "Reservation list" do
    it "adds each new reservation to the list of reservations" do
      expect(frontdesk.reservations).must_be_kind_of Array
      expect(frontdesk.reservations.length).must_equal 0

      frontdesk.reserve_room(check_in: "feb3", check_out: "feb5")

      expect(frontdesk.reservations.length).must_equal 1

      frontdesk.reserve_room(check_in: "feb4", check_out: "feb6")

      expect(frontdesk.reservations.length).must_equal 2
    end

    it "can find a reservation by date" do
      frontdesk.reserve_room(check_in: "feb3", check_out: "feb5")

      res2 = frontdesk.reserve_room(check_in: "feb4", check_out: "feb6")

      frontdesk.reserve_room(check_in: "feb5", check_out: "feb7")

      expect(frontdesk.find_reservations_by_date(date: "feb3")).must_be_kind_of Array

      expect(frontdesk.find_reservations_by_date(date: "feb3").length).must_equal 1

      expect(frontdesk.find_reservations_by_date(date: "feb5").length).must_equal 2

      expect(frontdesk.find_reservations_by_date(date: "feb3")[0]).must_be_kind_of Hotel::Reservation

      expect(frontdesk.find_reservations_by_date(date: "feb5")[0]).must_equal res2
    end
  end

  describe "Open rooms" do
    it "can find open rooms for a date range" do
      open = frontdesk.open_rooms(check_in: "feb3", check_out: "feb5")
      expect(open).must_be_kind_of Array
      expect(open.first).must_be_kind_of Hotel::Room
      expect(open.first.available?(night: "feb5")).must_equal true
      open2 = frontdesk.open_rooms(nights: [Date.new(2019, 1, 2),
                                            Date.new(2019, 3, 2)])
      expect(open2).must_be_kind_of Array
      expect(open2.first).must_be_kind_of Hotel::Room
      expect(open2.first.available?(night: Date.new(2019, 3, 2))).must_equal true
    end

    it "raises an ArgumentError if insufficient parameters are given" do
      expect { frontdesk.open_rooms(check_in: "feb7") }.must_raise ArgumentError

      expect { frontdesk.open_rooms(check_out: "feb9") }.must_raise ArgumentError

      expect { frontdesk.open_rooms() }.must_raise ArgumentError
    end

    it "doesn't find open rooms when there are none available" do
      fd = Hotel::FrontDesk.new
      expect(fd.open_rooms(check_in: "feb8", check_out: "feb9")).must_be_kind_of Array

      20.times do |i|
        expect(fd.open_rooms(check_in: "feb7", check_out: "feb10").length).must_equal 20 - i

        res = fd.reserve_room(check_in: "feb7", check_out: "feb10")

        expect(res.room.number).must_equal i + 1
      end

      expect(fd.open_rooms(check_in: "feb8", check_out: "feb9")).must_be_kind_of Array

      expect(fd.open_rooms(check_in: "feb8", check_out: "feb9")).must_equal []
    end
  end

  describe "Find by room" do
    it "can find a room based on the room number" do
      room = frontdesk.find_room_by_number(room_number: 7)

      expect(room).must_be_kind_of Hotel::Room

      expect(room.number).must_equal 7
    end

    it "returns nil if no rooms are found" do
      expect(frontdesk.find_room_by_number(room_number: 21)).must_equal nil
    end
  end

  describe "Generate nights" do
    it "correctly extracts nights needed from days given" do
      reservation = frontdesk.reserve_room(check_in: "feb3", check_out: "feb5")

      check_in_date = Date.parse("feb3")
      check_out_date = Date.parse("feb5")

      days = check_out_date - check_in_date + 1
      nights = reservation.nights.length

      expect(days).must_equal 3
      expect(nights).must_equal 2
      expect(days - nights).must_equal 1
      expect(check_in_date).must_equal reservation.nights.first
      expect(check_out_date).must_equal Date.new(2019, 2, 5)
      expect(reservation.nights.last).must_equal Date.new(2019, 2, 4)
    end
  end

  describe "Rooms array" do
    it "generates an array of rooms" do
      expect(frontdesk.rooms).must_be_kind_of Array
      expect(frontdesk.rooms.length).must_equal 20
      expect(frontdesk.rooms.first).must_be_kind_of Hotel::Room
    end
  end

  describe "Create block" do
    let(:room_collection) { [1, 2, 3] }
    let(:room_collection2) { [4, 5, 6] }
    let(:room_rate) { 160 }
    let(:block) {
      frontdesk.create_block(check_in: "feb4",
                             check_out: "feb5",
                             room_collection: room_collection,
                             room_rate: room_rate)
    }

    it "is able to create a block" do
      expect(block).must_be_kind_of Hotel::Block
    end

    it "assigns rooms if just number of rooms is provided" do
      b = frontdesk.create_block(check_in: "feb4",
                                 check_out: "feb5",
                                 room_rate: room_rate,
                                 number_of_rooms: 4)

      expect(b).must_be_kind_of Hotel::Block
    end

    it "raises ArgumentError if neither room collection nor number of rooms are provided" do
      expect {
        frontdesk.create_block(check_in: "feb4",
                               check_out: "feb5",
                               room_rate: room_rate)
      }.must_raise ArgumentError
    end

    it "raises ArgumentError if room collection is provided and number of rooms provided does not match length" do
      expect {
        frontdesk.create_block(check_in: "feb4",
                               check_out: "feb5",
                               room_rate: room_rate,
                               room_collection: [1, 2, 3],
                               number_of_rooms: 4)
      }.must_raise ArgumentError
    end

    it "continues if room collection is provided and number of rooms provided matches length" do
      b = frontdesk.create_block(check_in: "feb4",
                                 check_out: "feb5",
                                 room_rate: room_rate,
                                 room_collection: [1, 2, 3],
                                 number_of_rooms: 3)
      expect(b).must_be_kind_of Hotel::Block

      one = frontdesk.find_room_by_number(room_number: 1)
      two = frontdesk.find_room_by_number(room_number: 2)
      three = frontdesk.find_room_by_number(room_number: 3)
      expect(b.rooms).must_equal [one, two, three]
    end

    it "raises an AvailabilityError if any of the rooms are not available for range of dates" do
      frontdesk.reserve_room(check_in: "feb4", check_out: "feb7", room_number: 1)
      expect { block }.must_raise AvailabilityError
    end

    it "does not raise an argument error if they try to book 5 rooms for block" do
      expect(frontdesk.create_block(check_in: "feb4", check_out: "feb5", room_collection: [1, 2, 3, 4, 5], room_rate: room_rate)).must_be_kind_of Hotel::Block
    end

    it "raises an argument error if they try to book more than 5 rooms for block" do
      rooms = [1, 2, 3, 4, 5, 6]
      expect { frontdesk.create_block(check_in: "feb4", check_out: "feb5", room_collection: rooms, room_rate: room_rate) }.must_raise ArgumentError
    end

    it "raises an argument error if they try to book more than 5 unspecified rooms for block" do
      rooms = [1, 2, 3, 4, 5, 6]
      expect { frontdesk.create_block(check_in: "feb4", check_out: "feb5", number_of_rooms: 6, room_rate: room_rate) }.must_raise ArgumentError
    end

    it "can reserve room that is not in rooms set aside for block on date" do
      expect(frontdesk.reserve_room(check_in: "feb4", check_out: "feb5", room_number: 4)).must_be_kind_of Hotel::Reservation
    end

    it "can reserve unspecified room" do
      expect(frontdesk.reserve_room(check_in: "feb4", check_out: "feb5")).must_be_kind_of Hotel::Reservation
    end

    it "cannot reserve room that is set aside for block on date" do
      block
      expect { frontdesk.reserve_room(check_in: "feb4", check_out: "feb5", room_number: 1) }.must_raise AvailabilityError
    end

    it "can reserve block when another block is booked for different rooms on date" do
      block
      expect(frontdesk.create_block(check_in: "feb4", check_out: "feb5", room_collection: room_collection2, room_rate: room_rate)).must_be_kind_of Hotel::Block
    end

    it "cannot reserve block that is set aside for another block on date" do
      block
      expect { frontdesk.create_block(check_in: "feb4", check_out: "feb5", room_collection: room_collection, room_rate: room_rate) }.must_raise AvailabilityError
    end

    it "can check if any rooms are available in a specific block" do
      block
      expect(block.has_available_rooms?).must_equal true

      frontdesk.reserve_room_in_block(id: 1)
      expect(block.has_available_rooms?).must_equal true

      frontdesk.reserve_room_in_block(id: 1)
      expect(block.has_available_rooms?).must_equal true

      frontdesk.reserve_room_in_block(id: 1)
      expect(block.has_available_rooms?).must_equal false
    end
  end

  describe "Reserve room in block" do
    let(:room_collection) { [1, 2, 3] }
    let(:room_collection2) { [4, 5, 6] }
    let(:room_rate) { 160 }
    let(:block) { frontdesk.create_block(check_in: "feb4", check_out: "feb5", room_collection: room_collection, room_rate: room_rate) }

    it "raises error or something if no rooms are available in a specific block" do
      block
      frontdesk.reserve_room_in_block(id: 1)
      frontdesk.reserve_room_in_block(id: 1)
      frontdesk.reserve_room_in_block(id: 1)
      expect { frontdesk.reserve_room_in_block(id: 1) }.must_raise AvailabilityError
    end

    it "can reserve a room from a hotel block" do
      block
      expect(frontdesk.reserve_room_in_block(id: 1)).must_be_kind_of Hotel::Reservation
    end

    it "can reserve a specific room from a hotel block" do
      block

      expect(frontdesk.reserve_room_in_block(room_number: 1, id: 1)).must_be_kind_of Hotel::Reservation
      expect { frontdesk.reserve_room_in_block(room_number: 1, id: 1) }.must_raise AvailabilityError

      expect(frontdesk.reserve_room_in_block(room_number: 2, id: 1)).must_be_kind_of Hotel::Reservation
      expect { frontdesk.reserve_room_in_block(room_number: 2, id: 1) }.must_raise AvailabilityError

      expect(frontdesk.reserve_room_in_block(room_number: 3, id: 1)).must_be_kind_of Hotel::Reservation
      expect { frontdesk.reserve_room_in_block(room_number: 3, id: 1) }.must_raise AvailabilityError
    end

    it "can't reserve a room that's not in block" do
      block

      expect { frontdesk.reserve_room_in_block(room_number: 4, id: 1) }.must_raise AvailabilityError
    end

    it "can find block by id" do
      this_block = block
      expect(frontdesk.blocks.first).must_equal this_block
      expect(frontdesk.find_block_by_id(id: 1)).must_equal this_block
    end
  end
end
