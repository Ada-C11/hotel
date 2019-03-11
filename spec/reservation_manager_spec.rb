require_relative "spec_helper"

describe "Reservation_manager" do
  it "creates instance of reservation_manager" do
    expect(Reservation_manager.new).must_be_instance_of Reservation_manager
  end

  describe "make_reservation" do
    it "returns an instance of Reservation" do
      new_rez = Reservation_manager.new

      expect(new_rez.make_reservation(reservation_id: 1, check_in_time: "3rd April 2019", check_out_time: "10th April 2019")).must_be_instance_of Reservation
    end
  end
end
