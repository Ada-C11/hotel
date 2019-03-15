require_relative "spec_helper"

describe "ReservationManager class" do
  describe "#initialize" do
    let (:manager) do
      manager = Hotel::ReservationManager.new
    end

    it "must be an instance of ReservationManager" do
      expect(manager).must_be_kind_of Hotel::ReservationManager
    end

    it "must create an array of all rooms in the hotel" do
      expect(manager.rooms).must_be_kind_of Array
      (0..19).each { |num| expect(manager.rooms[num]).must_be_kind_of Hotel::Room }
      assert_nil(manager.rooms[20], msg = nil)
    end

    it "creates an empty array for reservations" do
      expect(manager.reservations).must_be_kind_of Array
    end
  end

  describe "#request_reservation" do
    let (:manager) do
      manager = Hotel::ReservationManager.new
    end

    it "adds a reservation to the reservations array" do
      before_res = manager.reservations.length
      new_reservation = manager.request_reservation("2018-03-12", "2018-03-15", booking_name: "Kim")
      expect(manager.reservations.length).must_equal before_res + 1
    end

    it "accurately loads a reservation into the reservations array" do
      new_reservation = manager.request_reservation("2018-03-12", "2018-03-15", booking_name: "Kim")
      first_reservation = manager.reservations.first
      expect(first_reservation.check_in).must_equal Date.parse("2018-03-12")
      expect(first_reservation.check_out).must_equal Date.parse("2018-03-15")
      expect(first_reservation.all_dates).must_be_kind_of Array
      expect(first_reservation.all_dates.length).must_equal 3
      expect(first_reservation.all_dates[0]).must_equal Date.parse("2018-03-12")
      expect(first_reservation.room.number).must_be :<=, 20
      expect(first_reservation.room.number).must_be :>, 0
      expect(first_reservation.block_name).must_equal nil
    end

    it "adds the reservation to the room" do
      new_reservation = manager.request_reservation("2018-03-12", "2018-03-12", booking_name: "Kim")
      expect(manager.rooms.first.reservations.length).must_equal 1
    end
  end

  # describe "#find_room" do
  #   let (:manager) do
  #     manager = Hotel::ReservationManager.new
  #   end

  #   it "returns an instance of a room" do
  #     expect(manager.find_room(5)).must_be_kind_of Hotel::Room
  #   end

  #   it "returns the correct instance of a room" do
  #     room_one = manager.find_room(4)
  #     room_two = manager.find_room(20)
  #     expect(room_one.number).must_equal 4
  #     expect(room_two.number).must_equal 20
  #     expect(room_one.rate).must_equal 200
  #     expect(room_two.rate).must_equal 200
  #   end
  # end

  describe "#reservations_by_date" do
    before do
      @manager = Hotel::ReservationManager.new
      @first_reservation = @manager.request_reservation("2018-03-12", "2018-03-15", booking_name: "Kim")
      @second_reservation = @manager.request_reservation("2018-03-12", "2018-03-12", booking_name: "AJ")
      @third_reservation = @manager.request_reservation("2018-03-14", "2018-03-15", booking_name: "Dee")
      @fourth_reservation = @manager.request_reservation("2018-03-13", "2018-03-14", booking_name: "Chris")
    end

    it "returns an array" do
      expect(@manager.reservations_by_date("2018-03-12")).must_be_kind_of Array
    end

    it "returns an array that contains instances of reservations" do
      expect(@manager.reservations_by_date("2018-03-12")[0]).must_be_kind_of Hotel::Reservation
    end

    it "returns a list of all reservations for a given date" do
      expect(@manager.reservations_by_date("2018-03-14").length).must_equal 2
      expect(@manager.reservations_by_date("2018-03-12").length).must_equal 2
      expect(@manager.reservations_by_date("2018-03-15").length).must_equal 0
    end
  end

  describe "#available_rooms" do
    let (:manager) do
      manager = Hotel::ReservationManager.new
    end

    it "returns an array which includes instances of rooms" do
      rooms = manager.available_rooms("Feb 12, 2019", "Feb 14, 2019")
      expect(rooms).must_be_kind_of Array
      expect(rooms[0]).must_be_kind_of Hotel::Room
    end

    it "returns an array that does not contain unavailable rooms" do
      rooms = manager.available_rooms("Feb 12, 2019", "Feb 14, 2019")
      3.times { manager.request_reservation("Feb 12, 2019", "Feb 13, 2019", booking_name: "Dan") }
      updated_rooms = manager.available_rooms("Feb 12, 2019", "Feb 14, 2019")
      other_dates = manager.available_rooms("Feb 13, 2019", "Feb 13, 2019")
      expect(rooms.length).must_equal 20
      expect(updated_rooms.first.number).must_equal 4
      expect(updated_rooms.length).must_equal 17
      expect(other_dates.length).must_equal 20
    end

    it "returns an array of the correct length for check-in date not available" do
      rooms = manager.available_rooms("Feb 12, 2019", "Feb 14, 2019")
      reservation_one = manager.request_reservation("Feb 12, 2019", "Feb 13, 2019", booking_name: "Devin")
      updated_rooms = manager.available_rooms("Feb 12, 2019", "Feb 14, 2019")
      expect(rooms.length).must_equal 20
      expect(updated_rooms.length).must_equal 19
    end

    it "returns an empty array when no rooms are available" do
      rooms = manager.available_rooms("Feb 1, 2019", "Feb 2, 2019")
      20.times { manager.request_reservation("Feb 1, 2019", "Feb 2, 2019", booking_name: "Val") }
      updated_rooms = manager.available_rooms("Feb 1, 2019", "Feb 2, 2019")
      different_rooms = manager.available_rooms("Feb 4, 2019", "Feb 4, 2019")
      expect(rooms.length).must_equal 20
      expect(updated_rooms.length).must_equal 0
      expect {
        manager.request_reservation("feb1", "feb1", booking_name: "George")
      }.must_raise ArgumentError
      expect(different_rooms.length).must_equal 20
    end
  end

  describe "#request_block" do
    before do
      @manager = Hotel::ReservationManager.new
    end

    it "raises an ArgumentError if argument for number_of_rooms is greater than 5, or less than 0" do
      expect {
        [-2, 0, 1, 6, 9].each do |num|
          @manager.request_block(check_in: "Feb1",
                                 check_out: "Feb2",
                                 number_of_rooms: num,
                                 discount: 120,
                                 name: "Bob")
        end
      }.must_raise ArgumentError
    end

    it "does not add any part of the block to reservations unless all dates available" do
      19.times { @manager.request_reservation("Feb 1, 2019", "Feb 2, 2019", booking_name: "Val") }

      expect {
        @manager.request_block(check_in: "Jan30",
                               check_out: "Feb3",
                               number_of_rooms: 2,
                               discount: 120,
                               name: "Bob")
      }.must_raise ArgumentError
      expect(@manager.reservations.length).must_equal 19
    end

    it "adds each block reservation to the ReservationManger reservations" do
      # Jan, Mar, May, July, August, October, December
      @manager.request_block(check_in: "May2",
                             check_out: "June1",
                             number_of_rooms: 5,
                             discount: 120,
                             name: "Bob")

      expect(@manager.reservations.length).must_equal 5
    end

    it "adds all reservations to correct Rooms" do
      @manager.request_block(check_in: "May2",
                             check_out: "June1",
                             number_of_rooms: 5,
                             discount: 120,
                             name: "Bob")

      (0..4).each do |index|
        expect(@manager.rooms[index].reservations.first).must_be_kind_of Hotel::Reservation
      end
    end

    it "adds all reservations to ReservationManager" do
      @manager.request_block(check_in: "feb2", check_out: "feb3", number_of_rooms: 3, discount: 120, name: "Bob")
      expect(@manager.reservations.length).must_equal 3
    end

    it "applies discount rate to total_cost of room" do
      @manager.request_block(check_in: "Jan30",
                             check_out: "Feb3",
                             number_of_rooms: 2,
                             discount: 120,
                             name: "Bob")

      expect(@manager.reservations.first.total_cost).must_equal 120.0
    end
  end

  describe "#available_rooms_in_block" do
    before do
      @manager = Hotel::ReservationManager.new
      @manager.request_block(check_in: "feb2", check_out: "feb3", number_of_rooms: 4, discount: 150, name: "Sally")
      @available_rooms = @manager.available_rooms_in_block(block_name: "Sally")
    end

    it "returns an array" do
      expect(@available_rooms).must_be_kind_of Array
    end

    it "returns an array of the correct length" do
      expect(@available_rooms.length).must_equal 4
    end
  end
end
