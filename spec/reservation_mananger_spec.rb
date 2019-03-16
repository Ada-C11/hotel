require_relative "spec_helper"
describe "RESERVATION MANAGER TESTS" do
  describe "Reservation Manager class initialization & set up" do
    it "will return an instance of Reservation_Manager" do
      # skip
      test_manager = Reservation_Manager.new
      expect(test_manager).must_be_kind_of Reservation_Manager
    end
  end

  describe "#make_reservation in Reservation Manager" do
    it "will contain a collection of Reservation instances" do
      # skip
      test_manager = Reservation_Manager.new
      check_in = "2019-3-15"
      check_out = "2019-3-20"

      test_manager.make_reservation(check_in, check_out)
      expect(test_manager.all_reservations).must_be_kind_of Array

      test_manager.make_reservation(check_in, check_out)
      expect(test_manager.all_reservations[0]).must_be_kind_of Reservation
    end
    it "one new reservation updates all_reservations" do
      # skip
      #initialize
      test_manager = Reservation_Manager.new

      #set up
      test_manager.make_reservation("2019-3-15", "2019-3-20")
      expect(test_manager.all_reservations.length).must_equal 1
    end

    it "multiple reservations returns the correct number of reservations" do
      # skip
      test_manager = Reservation_Manager.new

      test_manager.make_reservation("2019-3-15", "2019-3-20")
      test_manager.make_reservation("2019-3-24", "2019-3-30")
      test_manager.make_reservation("2019-3-24", "2019-3-30")

      expect(test_manager.all_reservations.length).must_equal 3
    end

    it "can make reservation when check in is another check out" do
      # skip
      test_manager = Reservation_Manager.new
      test_manager.make_reservation("2019-3-15", "2019-3-20")
      test_manager.make_reservation("2019-3-20", "2019-3-21")

      check_rooms = test_manager.find_available_rooms("2019-3-15", "2019-3-21")
      first_reserve_room = test_manager.all_reservations[0].room
      second_reserve_room = test_manager.all_reservations[1].room

      # puts "These are all unavailable rooms"
      # test_manager.all_reservations.each do |reservation|
      #   puts "#{reservation.room}"
      # end

      expect(check_rooms.length).must_equal 19
      expect(first_reserve_room).must_equal second_reserve_room
    end

    it "must have different rooms if check in is day before another check out" do
      # skip
      test_manager = Reservation_Manager.new
      reserve_1 = test_manager.make_reservation("2019-3-15", "2019-3-20")
      reserve_2 = test_manager.make_reservation("2019-3-19", "2019-3-21")

      # puts "reserve 1 room: #{reserve_1}"
      # puts "reserve 2 room: #{reserve_2}"
      expect(reserve_1.room).wont_equal reserve_2.room
    end
  end

  describe "#find_reservation_date" do
    it "will return collection of Reservations when given a specific date range" do
      # skip
      test_manager = Reservation_Manager.new

      test_manager.make_reservation("2019-3-15", "2019-3-20")
      test_manager.make_reservation("2019-3-24", "2019-3-30")
      test_manager.make_reservation("2019-3-24", "2019-3-30")
      check_in = "2019-3-24"
      check_out = "2019-3-30"

      expect(test_manager.find_reservation_date(check_in, check_out)).must_include test_manager.all_reservations[-1]
      expect(test_manager.find_reservation_date(check_in, check_out)).must_include test_manager.all_reservations[-2]
      expect(test_manager.find_available_rooms(check_in, check_out).length).must_equal 18
    end

    ### THIS IS NOT WORKINGGGGGG!!!!!
    it "can find reservations made via regular and hotel block reservation" do
      skip
      test_manager = Reservation_Manager.new
      # check_in = Date.parse("2019-3-15")
      # check_out = Date.parse("2019-3-20")

      puts "I'M HEREEEEEEE!"
      room_num = 5
      block_id = 7
      test_manager.make_hotel_block(rand(1..6), "2019-3-15", "2019-3-20", room_num)
      test_manager.make_reservation("2019-3-15", "2019-3-20")
      test_manager.make_reservation("2019-3-15", "2019-3-20", is_hotel_blocker: true, block_id: block_id)

      # test_manager.make_reservation("2019-3-15", "2019-3-20")

      puts "This is all_reservations: #{test_manager.all_reservations}"
      expect(test_manager.find_reservation_date("2019-3-15", "2019-3-20").length).must_equal 2
    end
    # TODO: think of more tests for #find_reservation?
  end

  describe "#find_available_rooms" do
    it "returns list of available rooms - dates don't coincide" do
      # skip
      test_manager = Reservation_Manager.new
      check_in = "2019-4-5"
      check_out = "2019-4-7"
      test_manager.make_reservation("2019-3-15", "2019-3-20")
      check_rooms = test_manager.find_available_rooms(check_in, check_out)
      available_rooms = (1..20).map { |i| i }

      expect(check_rooms).must_be_kind_of Array
      expect(check_rooms).must_equal available_rooms
    end

    it "returns list of available rooms - dates overlap" do
      # skip
      test_manager = Reservation_Manager.new
      test_manager.make_reservation("2019-3-15", "2019-3-20")
      test_manager.make_reservation("2019-3-13", "2019-3-19")
      check_in = "2019-3-18"
      check_out = "2019-3-21"

      check_rooms = test_manager.find_available_rooms(check_in, check_out)

      expect(check_rooms.length).must_equal 18
    end

    it "returns list of available rooms - check in and check out day are the same" do
      test_manager = Reservation_Manager.new
      check_in = "2019-4-5"
      check_out = "2019-4-5"
      test_manager.make_reservation("2019-4-4", "2019-4-10")
      check_rooms = test_manager.find_available_rooms(check_in, check_out)

      expect(check_rooms).must_be_kind_of Array
      expect(check_rooms.length).must_equal 19
    end
  end

  describe "hotel block management" do
    it "returns dates that are available only to hotel block users" do
      test_manager = Reservation_Manager.new

      check_in = "2019-4-5"
      check_out = "2019-4-5"
      room_num = 5
      block_id = rand(1..6)
      testing_block = test_manager.make_hotel_block(block_id, check_in, check_out, room_num)

      # puts "this is testing_block: #{testing_block}"
      expect(testing_block.length).must_equal 5
      expect(testing_block).must_be_kind_of Array
    end

    it "updates all_blocks to include the block rooms created" do
      test_manager = Reservation_Manager.new
      check_in = "2019-4-5"
      check_out = "2019-4-10"
      room_num = 5
      block_id = rand(1..6)
      test_manager.make_hotel_block(block_id, check_in, check_out, room_num)

      check_in = "2019-3-5"
      check_out = "2019-3-10"
      room_num = 5
      test_manager.make_hotel_block(block_id, check_in, check_out, room_num)

      expect(test_manager.all_block_reservations.length).must_equal 10
    end
    it "removes the blocked rooms from the list of available rooms" do
      test_manager = Reservation_Manager.new
      check_in = "2019-4-5"
      check_out = "2019-4-10"
      room_num = 5
      block_id = rand(1..6)
      test_manager.make_hotel_block(block_id, check_in, check_out, room_num)

      check_in = "2019-3-5"
      check_out = "2019-3-10"
      room_num = 5
      test_manager.make_hotel_block(block_id, check_in, check_out, room_num)

      date1 = "2019-4-5"
      date2 = "2019-4-10"

      expect(test_manager.find_available_rooms(date1, date2).length).must_equal 15
    end

    it "cannot make a reservation for hotel block room when not part of that party" do
      test_manager = Reservation_Manager.new

      check_in = "2019-4-5"
      check_out = "2019-4-10"
      room_num = 1
      block_id = rand(1..6)
      test_manager.make_hotel_block(block_id, check_in, check_out, room_num)
      check_in = "2019-3-5"
      check_out = "2019-3-10"
      room_num = 5
      test_manager.make_hotel_block(block_id, check_in, check_out, room_num)

      outsider_reservation = test_manager.make_reservation(check_in, check_out)
      expect(outsider_reservation).wont_equal test_manager.all_block_reservations[1].room
    end

    it "will raise argument error if hotel blocks have taken up all rooms and outsider tries to reserve" do
      test_manager = Reservation_Manager.new

      check_in = "2019-4-5"
      check_out = "2019-4-10"
      room_num = 5
      block_id = rand(1..6)

      4.times do
        test_manager.make_hotel_block(block_id, check_in, check_out, room_num)
      end

      expect { test_manager.make_reservation("2019-4-9", "2019-4-11") }.must_raise ArgumentError
    end

    it "will raise argument error if not enough rooms for hotel block" do
      test_manager = Reservation_Manager.new

      check_in = "2019-4-5"
      check_out = "2019-4-10"
      room_num = 5
      block_id = 3

      4.times do
        test_manager.make_hotel_block(block_id, check_in, check_out, room_num)
      end

      expect { test_manager.make_hotel_block("2019-4-9", "2019-4-11") }.must_raise ArgumentError
    end
  end

  describe "make reservation for hotel blocked room" do
    it "cannot make a reservation for hotel blocked room if not part of block" do
      test_manager = Reservation_Manager.new

      #assign a hotel block
      check_in = "2019-4-5"
      check_out = "2019-4-10"
      room_num = 5
      block_id = rand(1..6)
      4.times do
        test_manager.make_hotel_block(block_id, check_in, check_out, room_num)
      end

      expect { test_manager.make_reservation(check_in, check_out) }.must_raise ArgumentError
    end

    it "can make a reservation for hotel blocked room if part of block" do
      test_manager = Reservation_Manager.new

      #assign a hotel block
      check_in = "2019-4-5"
      check_out = "2019-4-10"
      room_num = 5
      3.times do
        test_manager.make_hotel_block(rand(1..6), check_in, check_out, room_num)
      end
      test_manager.make_hotel_block(7, check_in, check_out, room_num)

      expect(test_manager.make_reservation(check_in, check_out, is_hotel_blocker: true, block_id: 7)).must_be_kind_of Reservation
    end

    it "will have a discounted total rate if room booked is part of hotel block" do
      test_manager = Reservation_Manager.new

      #assign a hotel block
      check_in = "2019-4-5"
      check_out = "2019-4-10"
      room_num = 5
      block_id = 7
      3.times do
        test_manager.make_hotel_block(rand(1..6), check_in, check_out, room_num)
      end
      test_manager.make_hotel_block(block_id, check_in, check_out, room_num)

      #make reservation within that block
      block_test_reserve = test_manager.make_reservation(check_in, check_out, is_hotel_blocker: true, block_id: block_id)

      #check block_test_reserve cost
      expect(block_test_reserve.cost(block_test_reserve.duration)).must_equal (5 * 150)
    end

    it "will reassign the dates of hotel blocker to set duration regardless of their input" do
      test_manager = Reservation_Manager.new

      #assign a hotel block
      check_in = "2019-4-5"
      check_out = "2019-4-10"
      room_num = 5
      block_id = 7
      3.times do
        test_manager.make_hotel_block(rand(1..6), check_in, check_out, room_num)
      end
      test_manager.make_hotel_block(block_id, check_in, check_out, room_num)

      new_in_date = "2019-4-6"
      new_out_date = "2019-4-8"

      #make reservation within that block
      block_test_reserve = test_manager.make_reservation(new_in_date, new_out_date, is_hotel_blocker: true, block_id: block_id)

      #check new checkin/checkout dates
      expect(block_test_reserve.check_in).must_equal Date.parse(check_in)
      expect(block_test_reserve.check_out).must_equal Date.parse(check_out)
    end

    it "will reassign the room of hotel blocker to available room" do
      test_manager = Reservation_Manager.new

      #assign a hotel block
      check_in = "2019-4-5"
      check_out = "2019-4-10"
      room_num = 3
      block_id = 7
      test_manager.make_hotel_block(block_id, check_in, check_out, room_num)

      # make list of rooms available to hotel blockers
      room_options = []
      test_manager.all_block_reservations.each do |reservation|
        room_options << reservation.room
      end

      #make reservation within that block
      new_in_date = "2019-4-6"
      new_out_date = "2019-4-8"
      block_test_reserve1 = test_manager.make_reservation(new_in_date, new_out_date, is_hotel_blocker: true, block_id: block_id)
      block_test_reserve2 = test_manager.make_reservation(new_in_date, new_out_date, is_hotel_blocker: true, block_id: block_id)
      block_test_reserve3 = test_manager.make_reservation(new_in_date, new_out_date, is_hotel_blocker: true, block_id: block_id)

      puts "BLOCKED RESERAVTION ROOMS!!!!!!"
      puts block_test_reserve1.room
      puts block_test_reserve2.room
      puts block_test_reserve3.room

      expect(block_test_reserve1.room).wont_equal block_test_reserve2.room
      expect(room_options).must_include block_test_reserve1.room
      expect(test_manager.all_block_reservations.length).must_equal 0
    end
  end
  describe "finding block availability" do
    it "returns pending reservations for block" do
      test_manager = Reservation_Manager.new

      check_in = "2019-4-5"
      check_out = "2019-4-10"
      room_num = 5
      block_id = 8
      test_manager.make_hotel_block(block_id, check_in, check_out, room_num)
      test_manager.make_reservation(check_in, check_out, is_hotel_blocker: true, block_id: 8)
      test_manager.make_reservation(check_in, check_out, is_hotel_blocker: true, block_id: 8)

      expect(test_manager.all_block_reservations.length).must_equal 3
    end
  end
end
