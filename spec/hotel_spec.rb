require_relative "./spec_helper"

describe "Hotel" do
  describe "#initialize" do
    before do
      @hotel = BookingSystem::Hotel.new
    end

    it "creates an instance of Hotel" do
      expect(@hotel).must_be_kind_of BookingSystem::Hotel
    end
  end

  describe "#self.all" do

  end

  describe "#available?" do

  end

  describe "#book" do

  end

  describe "#reservations_by_date" do

  end
end