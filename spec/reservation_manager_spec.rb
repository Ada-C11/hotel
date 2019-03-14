require_relative "spec_helper"

describe "Reservation_manager" do
  let (:res_manager) {
    Reservation_manager.new
  }
  it "creates instance of reservation_manager" do
    expect(res_manager).must_be_instance_of Reservation_manager
  end

  describe "find_reservation" do
    it "returns an array of reservations" do
      res_manager.make_reservation(1, reservation_id: 1, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")
      res_manager.make_reservation(2, reservation_id: 2, check_in_time: "11th April 2019", check_out_time: "2nd May 2019")
      res_manager.make_reservation(3, reservation_id: 7, check_in_time: "22nd March 2019", check_out_time: "5th April 2019")

      expect(res_manager.find_reservations("4th April 2019")).must_be_instance_of Array
    end

    it "includes array of reservations that only include the specified date" do
      res_manager.make_reservation(1, reservation_id: 1, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")
      res_manager.make_reservation(2, reservation_id: 2, check_in_time: "11th April 2019", check_out_time: "2nd May 2019")
      res_manager.make_reservation(3, reservation_id: 7, check_in_time: "22nd March 2019", check_out_time: "5th April 2019")

      expect(res_manager.find_reservations("4th April 2019").length).must_equal 2
    end
  end

  describe "find_available_room method" do
    it "should return an array of room numbers" do
      expect(res_manager.find_available_rooms("1st April 2019", "4th April 2019")).must_be_instance_of Array
    end

    it "should return all 20 rooms if there are no date conflicts" do
      res_manager.make_reservation(1, check_in_time: "2nd January 2019", check_out_time: "20th January 2019")
      res_manager.make_reservation(2, check_in_time: "4th April 2019", check_out_time: "20th April 2019")
      res_manager.make_reservation(3, check_in_time: "22nd March 2019", check_out_time: "1st April 2019")

      expect(res_manager.find_available_rooms("1st April 2019", "4th April 2019").length).must_equal 20
    end

    it "should remove a room from list of available rooms if there is a conflict" do
      res_manager.make_reservation(1, check_in_time: "2nd April 2019", check_out_time: "10th April 2019")
      res_manager.make_reservation(2, check_in_time: "3rd april 2019", check_out_time: "20th april 2019")
      res_manager.make_reservation(3, check_in_time: "24nd march 2019", check_out_time: "2nd april 2019")

      expect(res_manager.find_available_rooms("1st April 2019", "4th April 2019").length).must_equal 17
    end

    it "should NOT remove rooms from list of available rooms if check-in-day overlaps with another check-out-day (or vice versa)" do
      res_manager.make_reservation(2, check_in_time: "4th april 2019", check_out_time: "20th april 2019")
      res_manager.make_reservation(3, check_in_time: "22nd march 2019", check_out_time: "1st april 2019")
      #this room is the only one with a conflict:
      res_manager.make_reservation(19, check_in_time: "2nd april 2019", check_out_time: "7th april 2019")

      expect(res_manager.find_available_rooms("1st April 2019", "4th April 2019").length).must_equal 19
    end

    it "should return an empty array if there are no rooms available" do
      room_num = 1
      20.times do |res|
        res_manager.make_reservation(room_num, check_in_time: "2nd April 2019", check_out_time: "10th April 2019")
        room_num += 1
      end
      expect(res_manager.find_available_rooms("1st April 2019", "4th April 2019").length).must_equal 0
    end
  end

  describe "make_reservation" do
    it "returns an instance of Reservation" do
      expect(res_manager.make_reservation(1, reservation_id: 1, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")).must_be_instance_of Reservation
    end

    it "adds reservations to list of reservations" do
      res_manager.make_reservation(1, reservation_id: 1, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")
      res_manager.make_reservation(2, reservation_id: 2, check_in_time: "11th April 2019", check_out_time: "2nd May 2019")

      expect(res_manager.reservations.length).must_equal 2
    end

    it "should raise an error if you try to book a room that is already booked for that time frame" do
      res_manager.make_reservation(1, check_in_time: "2nd April 2019", check_out_time: "10th April 2019")

      expect { res_manager.make_reservation(1, check_in_time: "5th April 2019", check_out_time: "23rd April 2019") }.must_raise ArgumentError
    end

    it "should NOT raise an error if you try to book a room that is already booked with 'legal' time overlaps" do
      res_manager.make_reservation(1, check_in_time: "2nd April 2019", check_out_time: "10th April 2019")
      res_manager.make_reservation(1, check_in_time: "10th april 2019", check_out_time: "21st april 2019")

      expect(res_manager.reservations.length).must_equal 2
    end 
  end
end
