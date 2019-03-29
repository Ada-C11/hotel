require_relative "spec_helper"

describe "Reservation_manager" do
  let (:res_manager) {
    Reservation_manager.new
  }
  let (:res_one) {
    res_manager.make_reservation(1, check_in_day: "3rd April 2019", check_out_day: "10th April 2019")
  }
  let (:res_two) {
    res_manager.make_reservation(2, check_in_day: "11th April 2019", check_out_day: "2nd May 2019")
  }
  let (:res_three) {
    res_manager.make_reservation(3, check_in_day: "22nd March 2019", check_out_day: "5th April 2019")
  }
  let (:res_six) {
    res_manager.make_reservation(1, check_in_day: "2nd April 2019", check_out_day: "10th April 2019")
  }
  let(:hotel_block_one) {
    res_manager.reserve_hotel_block(1, "7th June 2020", "12th June 2020", [2, 3, 4, 5, 6], 150)
  }
  let(:hotel_block_two) {
    res_manager.reserve_hotel_block(1, "6th July 2020", "16th July 2020", [1, 2, 3, 4], 150)
  }

  it "creates instance of reservation_manager" do
    expect(res_manager).must_be_instance_of Reservation_manager
  end

  describe "all rooms" do
    it "can access a list of all the rooms in the hotel" do
      expect(res_manager.all_rooms.length).must_equal 20
    end
    it "has rooms 1-20 in ascending order" do
      expect(res_manager.all_rooms.first).must_equal 1
      expect(res_manager.all_rooms.last).must_equal 20
    end
  end

  describe "find_reservation(date) method" do
    it "returns an array of reservations" do
      res_one
      res_two
      res_three

      expect(res_manager.find_reservations("4th April 2019")).must_be_instance_of Array
    end

    it "includes array of reservations that only include the specified date" do
      res_one
      res_two
      res_three

      expect(res_manager.find_reservations("4th April 2019")).must_include res_one
      expect(res_manager.find_reservations("4th April 2019").length).must_equal 2
    end
  end

  describe "find_available_room method" do
    let(:res_four) {
      res_manager.make_reservation(4, check_in_day: "22nd March 2019", check_out_day: "1st April 2019")
    }

    let(:res_five) {
      res_manager.make_reservation(5, check_in_day: "4th April 2019", check_out_day: "20th April 2019")
    }
    let(:find_rooms_one) {
      res_manager.find_available_rooms("1st April 2019", "4th April 2019")
    }

    it "should return an array of room numbers" do
      expect(find_rooms_one).must_be_instance_of Array
    end

    it "should return all 20 rooms if there are no date conflicts" do
      res_manager.make_reservation(1, check_in_day: "2nd January 2019", check_out_day: "20th January 2019")
      res_four
      res_five

      expect(find_rooms_one.length).must_equal 20
    end

    it "should remove a room from list of available rooms if there is a conflict" do
      res_six
      res_manager.make_reservation(2, check_in_day: "3rd april 2019", check_out_day: "20th april 2019")
      res_manager.make_reservation(3, check_in_day: "24nd march 2019", check_out_day: "2nd april 2019")

      expect(find_rooms_one.length).must_equal 17
    end

    it "should NOT remove rooms from list of available rooms if check-in-day overlaps with another check-out-day (or vice versa)" do
      res_four
      res_five
      #this room is the only one with a conflict:
      res_manager.make_reservation(19, check_in_day: "2nd april 2019", check_out_day: "7th april 2019")

      expect(find_rooms_one.length).must_equal 19
    end

    it "should return an empty array if there are no rooms available" do
      room_num = 1
      20.times do |res|
        res_manager.make_reservation(room_num, check_in_day: "2nd April 2019", check_out_day: "10th April 2019")
        room_num += 1
      end
      expect(find_rooms_one.length).must_equal 0
    end

    it "rooms are unavailable if they are part of a block" do
      hotel_block_one

      rooms_free_to_book = res_manager.find_available_rooms("7th June 2020", "10th June 2020")

      [2, 3, 4, 5, 6].each do |room_num|
        expect(rooms_free_to_book).wont_include room_num
      end
    end
  end

  describe "make_reservation" do
    it "returns an instance of Reservation" do
      expect(res_one).must_be_instance_of Reservation
    end

    it "adds reservations to list of reservations" do
      res_one
      res_two

      expect(res_manager.reservations.length).must_equal 2
    end

    it "should raise an error if you try to book a room that is already booked for that time frame" do
      res_six

      expect { res_manager.make_reservation(1, check_in_day: "5th April 2019", check_out_day: "23rd April 2019") }.must_raise ArgumentError
    end

    it "should NOT raise an error if you try to book a room that is already booked with 'legal' time overlaps" do
      res_six
      res_manager.make_reservation(1, check_in_day: "10th april 2019", check_out_day: "21st april 2019")

      expect(res_manager.reservations.length).must_equal 2
    end

    it "should raise an error if you try to book a room that is set aside for a block" do
      hotel_block_two

      expect { res_manager.make_reservation(4, check_in_day: "14th July 2020", check_out_day: "21st July 2020") }.must_raise ArgumentError
    end
  end

  describe "find_available_rooms_in_a_block method" do
    let(:available_rooms_in_block_one) {
      res_manager.find_available_rooms_in_a_block(1)
    }
    it "should return an array of rooms" do
      hotel_block_two
      expect(available_rooms_in_block_one).must_be_instance_of Array
    end

    it "should only return rooms for specific blocks" do
      hotel_block_two
      res_manager.reserve_hotel_block(2, "2nd July 2020", "7th July 2020", [14, 15, 16, 17, 18], 150)

      expect(available_rooms_in_block_one.length).must_equal 4
      expect(res_manager.find_available_rooms_in_a_block(2).length).must_equal 5
    end

    it "should not return a room if it has been booked" do
      hotel_block_two
      3.times do |res|
        res_manager.make_reservation_from_block(1)
      end

      expect(available_rooms_in_block_one.length).must_equal 1
    end

    it "should return an empty array if there are no available rooms in the block" do
      hotel_block_two
      4.times do |res|
        res_manager.make_reservation_from_block(1)
      end
      expect(available_rooms_in_block_one.length).must_equal 0
      expect(available_rooms_in_block_one).must_be_instance_of Array
    end
  end

  describe "make_reservation_from_block method" do
    let(:hotel_block_seven) {
      res_manager.reserve_hotel_block(7, "7th June 2020", "12th June 2020", [2, 3, 4, 5, 6], 150)
    }
    let(:block_res_seven) {
      res_manager.make_reservation_from_block(7)
    }
    it "allows someone to reserve a room that's part of a block if block_id is present in pending reservations for blocks" do
      hotel_block_one
      block_res = res_manager.make_reservation_from_block(1)

      expect(res_manager.reservations).must_include block_res
    end

    it "should raise error if there are no more available rooms in a block" do
      hotel_block_seven
      5.times do |res|
        res_manager.make_reservation_from_block(7)
      end
      expect { res_manager.make_reservation_from_block(7) }.must_raise ArgumentError
    end

    it "if reservation is part of a block, it must have a room number that is part of block" do
      hotel_block_seven
      block_res_seven

      expect([2, 3, 4, 5, 6]).must_include block_res_seven.room_number
    end

    it "if reservation is part of a block, it must have the same dates as the block" do
      hotel_block_seven
      block_res_seven

      expect(block_res_seven.check_in_day).must_equal Date.parse("7th June 2020")
    end

    it "if reservation is part of block, it's reservation_id must match block_id" do
      hotel_block_seven
      block_res_seven

      expect(block_res_seven.reservation_id).must_equal 7
    end

    it "should be in list of reservations for hotel" do
      hotel_block_seven
      block_res_seven

      expect(res_manager.reservations).must_include block_res_seven
    end

    it "should reflect discounted room rate" do
      hotel_block_seven
      block_res_seven

      expect(block_res_seven.calculate_total_cost).must_equal 750
    end

    it "find_reservations should be able to find a reservation in a block" do
      hotel_block_seven
      block_res_seven

      expect(res_manager.find_reservations("10th June 2020")).must_include block_res_seven
    end
  end

  describe "reserve_hotel_block" do
    it "returns an array for block" do
      expect(hotel_block_one).must_be_instance_of Array
    end

    it "contains Reservation instances for as many rooms as was requested" do
      expect(hotel_block_one.length).must_equal 5
    end

    it "raises an error if a block conflicts with reservations already created" do
      res_manager.make_reservation(9, check_in_day: "2nd April 2020", check_out_day: "10th April 2020")
      res_manager.make_reservation(4, check_in_day: "4th June 2020", check_out_day: "11th June 2020")

      expect { hotel_block_one }.must_raise ArgumentError
    end

    it "raises an error if there is already a block for these rooms and dates" do
      hotel_block_one

      expect { res_manager.reserve_hotel_block(2, "5th June 2020", "11th June 2020", [6, 7, 8, 9], 150) }.must_raise ArgumentError
    end

    it "raises an error if there are too many rooms in a block" do
      expect { res_manager.reserve_hotel_block(3, "5th June 2020", "11th June 2020", [13, 14, 15, 16, 17, 18], 150) }.must_raise ArgumentError
    end

    it "raises an error if there are not enough rooms in a block" do
      expect { res_manager.reserve_hotel_block(5, "13th September 2019", "23rd September 2019", [3], 150) }.must_raise ArgumentError
    end

    it "raises an error if check-in/out times are invalid" do
      expect { res_manager.reserve_hotel_block(7, "23rd September 2019", "13th September 2019", [3, 4, 5], 150) }.must_raise ArgumentError
    end
  end

  describe "pending_reservations_for_blocks" do
    it "should be an array of Reservation instances" do
      hotel_block_one
      expect(res_manager.pending_reservations_for_blocks.first).must_be_instance_of Reservation
    end

    it "length should be contingent on number of blocks and their rooms" do
      hotel_block_one
      res_manager.reserve_hotel_block(2, "7th June 2020", "12th June 2020", [14, 15, 16, 17], 150)
      expect(res_manager.pending_reservations_for_blocks.length).must_equal 9
    end

    it "should be empty if no blocks have been created" do
      res_six
      expect(res_manager.pending_reservations_for_blocks.length).must_equal 0
    end
  end
end
