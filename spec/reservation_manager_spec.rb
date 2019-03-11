require_relative "spec_helper"

describe "ReservationManager class" do
  describe "Initialize" do
    it "Must be an instance of ReservationManager" do
      expect(ReservationManager.new).must_be_kind_of ReservationManager
    end
  end
end
