require_relative "spec_helper"

describe "Block" do
    describe "Block instantiation" do
        before do
            @block = HotelManagementSystem::Block.new(start_date: '11th Mar 2019', end_date: '15th Mar 2019')
        end

        it "must be instance of Block" do
            expect(@block).must_be_kind_of HotelManagementSystem::Block
        end

        it "has a start date" do 
            expect(@block.end_date).must_be_kind_of Date
        end

        it "has an end date" do
            expect(@block.end_date).must_be_kind_of Date 
        end

        it "has a collection of rooms" do
            expect(@block.room_collection).must_be_kind_of Array
        end

        it "has a discount rate" do
            expect(@block.discount_rate).must_equal 0.8
        end
    end
end