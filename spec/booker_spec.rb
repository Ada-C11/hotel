require_relative "spec_helper"

describe "Booker Class" do
    describe "Initialization of booker"
        let(:booker) {Hotel::Booker.new}

        it "is an instance of Booker" do
            expect(booker).must_be_kind_of Hotel::Booker
        end

        it "lists all rooms" do
            expect(booker.rooms).must_be_kind_of Array
            expect(booker.rooms[0]).must_be_kind_of Hotel::Room
            expect(booker.rooms.length).must_equal 20
        end
    
        it "lists all reservations" do
            expect(booker.reservations).must_be_kind_of Array
        end
    end

    describe "book_room method"
        

    end 
end