require_relative "spec_helper"

describe "Block Class" do
    
    it "is an instance of Block" do
        block = Hotel::Block.new(id: 1, block_reservations: [1,2,3])
        expect(block).must_be_kind_of Hotel::Block
    end
  
end