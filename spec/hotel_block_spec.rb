require_relative "spec_helper.rb"
require_relative "../lib/hotel.rb"


describe "HotelBlock class" do
    before do 
        @hotel = HotelSystem::Hotel.new(20)
        @hotel.create_block(start_year: 2019, start_month: 4, start_day: 20, num_nights: 5, room_nums: [4, 5, 6], block_rate: 150)
        @block1 = @hotel.blocks[0]
    end

    describe "instantiation" do
        it "is created with an array of rooms" do
            expect(@block1.rooms).must_be_kind_of Array
            expect(@block1.rooms[0]).must_be_kind_of HotelSystem::Room
        end
  
        it "begins with the available_rooms array being identical to the list of rooms at instantiation" do
            expect(@block1.rooms).must_equal @block1.available_rooms
        end
    end


end