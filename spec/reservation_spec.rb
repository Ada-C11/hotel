require "spec_helper"
require "date"

describe "Reservation class" do
  describe "Initialize" do
    
    it "raises an ArgumentError when the end date is before the start date" do
      expect{ Hotel::Reservation.new(res_id: 5, room: 9, check_in_date: "2019-05-10", check_out_date: "2019-05-09") }.must_raise ArgumentError
    end
    
    it "establishes the base data structures when instantiated" do
       reservation = Hotel::Reservation.new(res_id: 1, 
                                            room: 5, 
                                            check_in_date:"2019-1-1",
                                            check_out_date:"2019-1-10")
        

        expect(reservation.res_id).must_be_kind_of Integer
        expect(reservation.room).must_be_kind_of Integer
        expect(reservation.check_in_date).must_be_kind_of String
    end
    
  end 
end