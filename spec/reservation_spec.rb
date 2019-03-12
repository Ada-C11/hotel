require "spec_helper"
require "date"

describe "Reservation class" do
  describe "Initialize" do
    it "raises an ArgumentError when the end date is before the start date" do
      expect{Hotel::Reservation.new(res_id: 5, room: 9, check_in_date: "2019-05-10", check_out_date: "2019-05-09")}.must_raise ArgumentError
    end
  end 
end