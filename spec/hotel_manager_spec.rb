require_relative "spec_helper"

describe "Hotel Manager" do
    describe "Room instantiation" do
        it "list rooms" do 
            expect(HotelManagementSystem::HotelManager.new.list_rooms).must_be_kind_of Array
        end
    end
    
    describe "Hotel Manager actions" do
        before do
            @hotelmanager = HotelManagementSystem::HotelManager.new
        end

        it "makes a reservations" do
            expect(@hotelmanager.reserve('11th Mar 2019', '15th Mar 2019')).must_be_kind_of HotelManagementSystem::Reservation
        end

        it "provides the total cost of a reservation" do
            reservation = @hotelmanager.reserve('11th Mar 2019', '15th Mar 2019')
            expect(@hotelmanager.reservation_cost(reservation)).must_equal 800
        end

        it "returns all available rooms for requested dates" do
            start_date = '11th Mar 2019'
            end_date = '15th Mar 2019'
            @hotelmanager.reserve(start_date, end_date)
            expect(@hotelmanager.list_available_rooms(start_date, end_date)).must_be_kind_of Array
            (@hotelmanager.list_available_rooms(start_date, end_date)).length.must_equal 19
        end

        it "raises an exception when no room is available for requested dates" do
            hotelmanager = HotelManagementSystem::HotelManager.new
            start_date = '11th Mar 2019'
            end_date = '15th Mar 2019'

            20.times do
                start_date = '11th Mar 2019'
                end_date = '15th Mar 2019'
                hotelmanager.reserve(start_date, end_date)
            end
        
            expect{hotelmanager.reserve(start_date, end_date)}.must_raise ArgumentError

        end

        it "returns all reservations by date" do
            arraylength1 = @hotelmanager.reservations_by_date('13th Mar 2019').length
            expect(arraylength1).must_equal 0
            @hotelmanager.reserve('11th Mar 2019', '15th Mar 2019')
            arraylength2 = @hotelmanager.reservations_by_date('13th Mar 2019').length
            expect(arraylength2).must_equal 1
            expect(@hotelmanager.reservations_by_date('13th Mar 2019')).must_be_kind_of Array
        end

        # testing for blocks

        it "creates a room block" do
            expect(@hotelmanager.block_rooms('11th Mar 2019', '15th Mar 2019', 5, 0.8)).must_be_kind_of HotelManagementSystem::Block
        end

        it "raises an exception if a block is the wrong size" do
            expect{@hotelmanager.block_rooms('11th Mar 2019', '15th Mar 2019', 6, 0.8)}.must_raise ArgumentError
        end

        it "raises an exception if not enough rooms are available to block" do
            hotelmanager = HotelManagementSystem::HotelManager.new
            start_date = '11th Mar 2019'
            end_date = '15th Mar 2019'

            19.times do
                start_date = '11th Mar 2019'
                end_date = '15th Mar 2019'
                hotelmanager.reserve(start_date, end_date)
            end

            expect{hotelmanager.block_rooms('11th Mar 2019', '15th Mar 2019', 2, 0.8)}.must_raise ArgumentError
        end

        it "returns all room blocks" do
            expect(@hotelmanager.list_blocks).must_be_kind_of Array
        end

        it "returns the cost of a block reservation" do
            block = @hotelmanager.block_rooms('11th Mar 2019', '15th Mar 2019', 5, 0.8)
            expect(@hotelmanager.cost_of_block(block)).must_equal 3200.0
        end
    end
end