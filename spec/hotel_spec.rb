require_relative "spec_helper"

describe "Hotel class" do
  describe "Hotel instantiation" do
    before do
      @hotel = Hotel::Hotel.new(
        id: 1,
        rooms: [],
        reservations: [],
      )
    end

    it "is an instance of Hotel" do
      expect(@hotel).must_be_kind_of Hotel::Hotel
    end
  end
end
