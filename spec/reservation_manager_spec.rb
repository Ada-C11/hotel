require_relative "spec_helper"

describe "ReservationManager class" do
  describe "Initialize" do
    let (:manager) do
      manager = ReservationManager.new
    end

    it "Must be an instance of ReservationManager" do
      expect(manager).must_be_kind_of ReservationManager
    end

    it "Must " do
      expect(manager.rooms).must_be_kind_of Array
      expect(manager.rooms[0]).must_be_kind_of Room
    end
  end
end
