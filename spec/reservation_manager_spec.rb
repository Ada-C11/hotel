require_relative "spec_helper"
require "pry"

describe "ReservationManager class" do
  let (:reservation_manager) do
    Hotel::ReservationManager.new
  end

  describe "initialize" do
    it "Creates an instance of ReservationManager" do
      expect(reservation_manager).must_be_instance_of Hotel::ReservationManager
    end
  end

  describe "make_reservation method" do
    it "make_reservation method can make an instance of reservation" do
      expect(reservation_manager.make_reservation(room: "1")).must_be_instance_of Hotel::Reservation
    end
    it "make_reservation adds a reservation to an array of reservations" do
      my_reservation = reservation_manager.make_reservation(room: "1")
      expect(reservation_manager.reservation_array.include?(my_reservation)).must_equal true
    end
    it "Reserves a room for a given date range" do
      reservation_manager.make_reservation(start_date: "1st Jan 2019", end_date: "3rd Jan 2019", room: "1")
      expect(reservation_manager.reservation_array[0].room).must_equal "1"
    end
    it "Allows user to reserve an available room for a given date range" do
      reservation_manager.make_reservation(start_date: "1st Jan 2019", end_date: "3rd Jan 2019", room: "1")
      reservation_manager.make_reservation(start_date: "1st Jan 2019", end_date: "3rd Jan 2019", room: "2")
      expect(reservation_manager.reservation_array[1].room).must_equal "2"
    end
    it "Allows user to reserve an available room for a given date range (starts on the checkout date)" do
      reservation_manager.make_reservation(start_date: "1st Jan 2019", end_date: "3rd Jan 2019", room: "1")
      reservation_manager.make_reservation(start_date: "3rd Jan 2019", end_date: "5th Jan 2019", room: "1")
      expect(reservation_manager.reservation_array[1].room).must_equal "1"
    end
    it "Allows user to reserve an available room for a given date range (ends on the checkin date)" do
      reservation_manager.make_reservation(start_date: "5th Jan 2019", end_date: "6th Jan 2019", room: "1")
      reservation_manager.make_reservation(start_date: "3rd Jan 2019", end_date: "5th Jan 2019", room: "1")
      expect(reservation_manager.reservation_array[1].room).must_equal "1"
    end
    it "Raises an ArgumentError if the user tries to book a room that is blocked using the make_reservation method instead of the make_block_reservation method" do
      reservation_manager.hotel_block(start_date: "2nd Jan 2019", end_date: "5th Jan 2019", rooms_array: ["18", "19", "20"], cost: 100, block_name: "kitten con")
      expect { reservation_manager.make_reservation(start_date: "2nd Jan 2019", end_date: "5th Jan 2019", room: "18", block_name: "kitten con") }.must_raise ArgumentError
    end
    it "Raises an ArgumentError if you try to reserve a room that is unavailable for a given date range (same dates)" do
      reservation_manager.make_reservation(start_date: "1st Jan 2019", end_date: "3rd Jan 2019", room: "1")
      expect { reservation_manager.make_reservation(start_date: "1st Jan 2019", end_date: "3rd Jan 2019", room: "1") }.must_raise ArgumentError
    end
    it "Raises an ArgumentError if you try to reserve a room that is unavailable for a given date range (overlaps one day)" do
      reservation_manager.make_reservation(start_date: "1st Jan 2019", end_date: "3rd Jan 2019", room: "1")
      expect { reservation_manager.make_reservation(start_date: "2nd Jan 2019", end_date: "4th Jan 2019", room: "1") }.must_raise ArgumentError
    end
    it "Raises an ArgumentError if you try to reserve a room that is unavailable for a given date range (completely contained)" do
      reservation_manager.make_reservation(start_date: "1st Jan 2019", end_date: "5th Jan 2019", room: "1")
      expect { reservation_manager.make_reservation(start_date: "2nd Jan 2019", end_date: "4th Jan 2019", room: "1") }.must_raise ArgumentError
    end
    it "Raises an ArgumentError if you try to reserve a room that is unavailable for a given date range (completely containing)" do
      reservation_manager.make_reservation(start_date: "2nd Jan 2019", end_date: "5th Jan 2019", room: "1")
      expect { reservation_manager.make_reservation(start_date: "1st Jan 2019", end_date: "6th Jan 2019", room: "1") }.must_raise ArgumentError
    end
  end

  describe "make_block_reservation" do
    it "Allows user to book a room that is blocked for a certain date range if it is for the entire block duration" do
      reservation_manager.hotel_block(start_date: "2nd Jan 2019", end_date: "5th Jan 2019", rooms_array: ["18", "19", "20"], cost: 100, block_name: "cat convention")
      expect (reservation_manager.make_block_reservation(start_date: "2nd Jan 2019", end_date: "5th Jan 2019", room: "18", cost: 100, block_name: "cat convention")).must_be_instance_of Hotel::Reservation
    end
    it "raises an error if you do not book the entire duration of the block" do
      reservation_manager.hotel_block(start_date: "2nd Jan 2019", end_date: "5th Jan 2019", rooms_array: ["18", "19", "20"], cost: 100, block_name: "kitty con")
      expect { reservation_manager.make_block_reservation(start_date: "3rd Jan 2019", end_date: "5th Jan 2019", room: "18", cost: 100, block_name: "kitty con") }.must_raise ArgumentError
    end
    it "Adds reservations for blocked rooms to @reservations_array" do
      reservation_manager.hotel_block(start_date: "2nd Jan 2020", end_date: "5th Jan 2020", rooms_array: ["18", "19", "20"], cost: 100, block_name: "animal convention")
      cat_block_reservation = reservation_manager.make_block_reservation(start_date: "2nd Jan 2020", end_date: "5th Jan 2020", room: "18", cost: 100, block_name: "animal convention")
      expect (reservation_manager.reservation_array.length).must_equal 1
    end
  end

  describe "hotel_block method" do
    it "Returns an array" do
      expect(reservation_manager.hotel_block(start_date: "2nd Jan 2019", end_date: "5th Jan 2019", rooms_array: ["18", "19", "20"], cost: 100).length).must_equal 3
    end
    it "Array contains booked rooms" do
      expect(reservation_manager.hotel_block(start_date: "2nd Jan 2019", end_date: "5th Jan 2019", rooms_array: ["18", "19", "20"], cost: 100).first).must_equal "18"
    end
    it "raises an exception if the user tries to book a block including a room that is booked during the date range" do
      reservation_manager.make_reservation(start_date: "2nd Feb 2020", end_date: "5th Feb 2020", room: "1")
      expect { reservation_manager.hotel_block(start_date: "3rd Feb 2020", end_date: "4th Feb 2020", rooms_array: ["1", "19", "20"], cost: 100) }.must_raise ArgumentError
    end
    it "raises an argument error if the user tries to create another hotel block for rooms that are already blocked for that date range" do
      reservation_manager.hotel_block(start_date: "2nd Jan 2019", end_date: "5th Jan 2019", rooms_array: ["1", "19", "20"], cost: 100)
      expect { reservation_manager.hotel_block(start_date: "3rd Jan 2019", end_date: "5th Jan 2019", rooms_array: ["19", "20"], cost: 100) }.must_raise ArgumentError
    end
    it "lets user create another multiple hotel blocks for the same dates if the rooms are unique" do
      reservation_manager.hotel_block(start_date: "2nd August 2019", end_date: "5th August 2019", rooms_array: ["7", "8", "9"], cost: 100)
      expect (reservation_manager.hotel_block(start_date: "2nd August 2019", end_date: "5th August 2019", rooms_array: ["10", "11", "12"], cost: 100).length).must_equal 6
    end
    it "lets user create a hotel block with rooms from exiting block but with unique days" do
      reservation_manager.hotel_block(start_date: "2nd August 2019", end_date: "5th August 2019", rooms_array: ["7", "8", "9"], cost: 100)
      expect (reservation_manager.hotel_block(start_date: "6th August 2019", end_date: "10th August 2019", rooms_array: ["7", "8", "9"], cost: 100).length).must_equal 6
    end
    it "lets user create a new hotel block on the checkout day of a previous hotel block with the same rooms" do
      reservation_manager.hotel_block(start_date: "2nd August 2019", end_date: "5th August 2019", rooms_array: ["7", "8", "9"], cost: 100)
      expect (reservation_manager.hotel_block(start_date: "5th August 2019", end_date: "10th August 2019", rooms_array: ["7", "8", "9"], cost: 100).length).must_equal 6
    end
  end

  describe "view_all_rooms method" do
    it "rooms array includes 20 rooms" do
      expect(reservation_manager.view_all_rooms.length).must_equal 20
    end
    it "rooms array includes rooms" do
      expect(reservation_manager.view_all_rooms.include?("15")).must_equal true
    end
  end

  describe "access_reservations_by_date method" do
    it "access_reservations_by_date method must return an array" do
      reservation_manager.make_reservation(start_date: "2nd July 2019", end_date: "5th July 2019", room: "1")
      reservation_manager.make_reservation(start_date: "2nd June 2019", end_date: "5th June 2019", room: "2")
      expect(reservation_manager.access_reservations_by_date("4th Jul 2019")).must_be_instance_of Array
    end
    it "access_reservations_by_date method must return an array containing reservations matching the date searched" do
      reservation_manager.make_reservation(start_date: "2nd July 2019", end_date: "5th July 2019", room: "1")
      reservation_manager.make_reservation(start_date: "2nd June 2019", end_date: "5th June 2019", room: "2")
      reservation_manager.make_reservation(start_date: "1st July 2019", end_date: "7th July 2019", room: "3")
      expect(reservation_manager.access_reservations_by_date("4th Jul 2019").length).must_equal 2
    end
    it "access_reservations_by_date method will return an empty array if the date searched has no matches" do
      reservation_manager.make_reservation(start_date: "2nd July 2019", end_date: "5th July 2019", room: "1")
      reservation_manager.make_reservation(start_date: "2nd June 2019", end_date: "5th June 2019", room: "2")
      expect(reservation_manager.access_reservations_by_date("10th Jul 2019").length).must_equal 0
    end
    it "access_reservations_by_date method will show a reservation made from a hotel block" do
      reservation_manager.hotel_block(start_date: "2nd Feb 2019", end_date: "5th Feb 2019", rooms_array: ["18", "19", "20"], cost: 100, block_name: "pet convention")
      reservation_manager.make_block_reservation(start_date: "2nd Feb 2019", end_date: "5th Feb 2019", cost: 100, room: "18", block_name: "pet convention")
      expect (reservation_manager.access_reservations_by_date("4th Feb 2019").length).must_equal 1
    end
  end

  describe "view block availability" do
    it "returns an array of all rooms in a block if none are booked" do
      reservation_manager.hotel_block(start_date: "2nd Feb 2019", end_date: "5th Feb 2019", rooms_array: ["18", "19", "20"], cost: 100, block_name: "dog convention")
      expect (reservation_manager.view_block_availability("dog convention").length).must_equal 3
    end
    it "returns an array of just the rooms associated with a given block, not all blocked rooms" do
      reservation_manager.hotel_block(start_date: "2nd Feb 2019", end_date: "5th Feb 2019", rooms_array: ["18", "19", "20"], cost: 100, block_name: "dog convention")
      reservation_manager.hotel_block(start_date: "2nd Feb 2019", end_date: "5th Feb 2019", rooms_array: ["15", "16", "17"], cost: 100, block_name: "cat convention")
      expect (reservation_manager.view_block_availability("dog convention").length).must_equal 3
    end
    it "returns an array of available rooms if some rooms in a block are booked" do
      reservation_manager.hotel_block(start_date: "2nd Feb 2019", end_date: "5th Feb 2019", rooms_array: ["18", "19", "20"], cost: 100, block_name: "unique pet convention")
      reservation_manager.make_block_reservation(start_date: "2nd Feb 2019", end_date: "5th Feb 2019", cost: 100, room: "18", block_name: "unique pet convention")
      expect (reservation_manager.view_block_availability("unique pet convention").length).must_equal 2
    end
  end

  describe "view available rooms method" do
    it "returns an array of available rooms for a given date range" do
      reservation_manager.make_reservation(start_date: "2nd July 2019", end_date: "5th July 2019", room: "1")
      expect(reservation_manager.view_available_rooms(start_date: "3rd July 2019", end_date: "9th July 2019").length).must_equal 19
    end
    it "Ignores trip end date since you don't need to book a room that night" do
      reservation_manager.make_reservation(start_date: "2nd July 2019", end_date: "5th July 2019", room: "1")
      expect(reservation_manager.view_available_rooms(start_date: "5th July 2019", end_date: "9th July 2019").length).must_equal 20
    end
    # add more tests to check limits of this
  end
end
