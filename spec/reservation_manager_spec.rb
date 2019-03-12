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

    it "loads reservations into reservations array" do
      before_res = manager.reservations.length
      new_reservation = manager.request_reservation("2018-03-12", "2018-03-15")
      expect(manager.reservations.length).must_equal before_res + 1
    end

    it "accurately loads reservations into reservations array" do
      new_reservation = manager.request_reservation("2018-03-12", "2018-03-15")
      first_reservation = manager.reservations.first
      expect(first_reservation.check_in_date).must_equal Date.strptime("2018-03-12")
      expect(first_reservation.check_out_date).must_equal Date.strptime("2018-03-15")
      expect(first_reservation.all_dates).must_equal Date.strptime("2018-03-12")..Date.strptime("2018-03-15")
      expect(first_reservation.room_number).must_be :<=, 20
      expect(first_reservation.room_number).must_be :>, 0
    end
  end

  describe "#reservations_by_date" do
    before do
      @manager = Hotel::ReservationManager.new
      @first_reservation = @manager.request_reservation("2018-03-12", "2018-03-15")
      @second_reservation = @manager.request_reservation("2018-03-12", "2018-03-12")
      @third_reservation = @manager.request_reservation("2018-03-14", "2018-03-15")
      @fourth_reservation = @manager.request_reservation("2018-03-13", "2018-03-14")
    end

    it "returns an array" do
      expect(@manager.reservations_by_date("2018-03-12")).must_be_kind_of Array
    end

    it "returns an array that contains instances of reservations" do
      expect(@manager.reservations_by_date("2018-03-12")[0]).must_be_kind_of Hotel::Reservation
    end

    it "returns a list of all reservations for a given date" do
      expect(@manager.reservations_by_date("2018-03-14").length).must_equal 3
      expect(@manager.reservations_by_date("2018-03-12").length).must_equal 2
      expect(@manager.reservations_by_date("2018-03-10").length).must_equal 0
    end
  end
end
