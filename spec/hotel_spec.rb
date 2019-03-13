require_relative "spec_helper"

describe "Hotel class" do
  let (:hotel) do
    Hotel.new
  end

  describe "initialize" do
    it "Creates an instance of Hotel" do
      expect(hotel).must_be_instance_of Hotel
    end
  end

  describe "creating a reservation" do
    before do
      hotel.make_reservation(check_in: Date.new(2005, 2, 2), check_out: Date.new(2005, 2, 4))
    end

    it "creates an object nstance of Reservation" do
      expect(hotel.reservations[0]).must_be_kind_of Reservation
    end

    # it "and puts it saves it as an instance vairable" do
    #   expect(@reservation[0].check_in).must_equal Date.new(2005, 2, 2)
    # end
  end
end
