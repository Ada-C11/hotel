require_relative "spec_helper"

describe "Reservation class" do
  describe "Reservation#initialize" do
    let(:valid_reservation) {
      Hotel::Reservation.new(start_date: "March 20, 2020", end_date: "March 27, 2020")
    }
    it "is an instance of Reservation" do
      expect(valid_reservation).must_be_instance_of Hotel::Reservation
    end
  end
end
