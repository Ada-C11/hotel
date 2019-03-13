require_relative 'spec_helper'

describe "Reservation class" do
  before do
    input = {
      :id => 50,
      :room => {rm_id: "Room #150", cost: COST},
      :check_in => "2019/07/19",
      :check_out => "2019/07/25"
    }
    @reservation = Hotel::Reservation.new(input)
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end
  end
end