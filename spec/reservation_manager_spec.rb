require_relative "spec_helper"

describe "Reservation_manager" do
  it "creates instance of reservation_manager" do
    expect(Reservation_manager.new).must_be_instance_of Reservation_manager
  end

  describe "make_reservation" do
    let (:new_rez_man) {
      Reservation_manager.new
    }
    it "returns an instance of Reservation" do
      expect(new_rez_man.make_reservation(reservation_id: 1, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")).must_be_instance_of Reservation
    end

    it "adds reservations to list of reservations" do
      reservation_one = new_rez_man.make_reservation(reservation_id: 1, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")
      reservation_two = new_rez_man.make_reservation(reservation_id: 2, check_in_time: "11th April 2019", check_out_time: "2nd May 2019")

      expect(new_rez_man.reservations.length).must_equal 2
    end
  end
end
