require_relative 'spec_helper'

describe "Reservation class" do

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
  end
end
