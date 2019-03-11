require_relative 'spec_helper'

describe "Booking" do
  describe "#initialize" do
    it "Is an instance of Booking" do
      booking = Hotel::Booking.new
      booking.must_be_kind_of Hotel::Booking
    end
  end
end