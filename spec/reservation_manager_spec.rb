require_relative "spec_helper"

describe "Reservation_manager" do
  let (:new_rez_man) {
    Reservation_manager.new
  }
  it "creates instance of reservation_manager" do
    expect(new_rez_man).must_be_instance_of Reservation_manager
  end

  describe "make_reservation" do
    it "returns an instance of Reservation" do
      expect(new_rez_man.make_reservation(reservation_id: 1, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")).must_be_instance_of Reservation
    end

    it "adds reservations to list of reservations" do
      reservation_one = new_rez_man.make_reservation(reservation_id: 1, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")
      reservation_two = new_rez_man.make_reservation(reservation_id: 2, check_in_time: "11th April 2019", check_out_time: "2nd May 2019")

      expect(new_rez_man.reservations.length).must_equal 2
    end
  end

  describe "find_reservation" do
    it "returns an array of reservations" do
      reservation_one = new_rez_man.make_reservation(reservation_id: 1, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")
      reservation_two = new_rez_man.make_reservation(reservation_id: 2, check_in_time: "11th April 2019", check_out_time: "2nd May 2019")
      reservation_three = new_rez_man.make_reservation(reservation_id: 7, check_in_time: "22nd March 2019", check_out_time: "5th April 2019")

      expect(new_rez_man.find_reservations("4th April 2019")).must_be_instance_of Array
    end

    it "includes array of reservations that only include the specified date" do
      reservation_one = new_rez_man.make_reservation(reservation_id: 1, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")
      reservation_two = new_rez_man.make_reservation(reservation_id: 2, check_in_time: "11th April 2019", check_out_time: "2nd May 2019")
      reservation_three = new_rez_man.make_reservation(reservation_id: 7, check_in_time: "22nd March 2019", check_out_time: "5th April 2019")

      expect(new_rez_man.find_reservations("4th April 2019").length).must_equal 2
    end
  end

  # describe "find_available_room method" do
  #   it "should return an array with length equal to number of rooms available" do
  #     rez_one = new_rez_man.make_reservation(check_in_time: "2nd April 2019", check_out_time: "10th April 2019")
  #     # => should not work
  #     rez_one = new_rez_man.make_reservation(check_in_time: "4th april 2019", check_out_time: "20th april 2019")
  #     # => should work
  #     rez_three = new_rez_man.make_reservation(check_in_time: "22nd march 2019", check_out_time: "1st april 2019")
  #     # => should work
  #     expect(new_rez_man.find_available_rooms(check_in_time: "1st April 2019", check_out_time: "4th April 2019").length).must_equal 2
  #     # expect(new_rez_man.find_available_room(check_in_time: "1st April 2019", "check_out_time: "4th April 2019")).must_equal [room number for rez one, room number for rez two]
  #   end
  # end
end
