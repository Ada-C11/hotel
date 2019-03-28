require_relative "spec_helper"

describe "Block Reservation Class" do
    
    it "is an instance of Block Reservation" do
        block_reservation = Hotel::Block_Reservation.new(id: 1, date_range: [1,2], room: 1, cost: 200, block: 1)
        expect(block_reservation).must_be_kind_of Hotel::Block_Reservation
    end
  
end