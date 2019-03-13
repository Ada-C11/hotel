require_relative "spec_helper"

describe "Booker Class" do
    let(:booker) {Hotel::Booker.new}

    describe "Initialization of booker" do

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

    describe "book_room method" do

        let(:call_book_room) {booker.book_room(start_date: 20190313, end_date: 20190316)}

        it "adds new reservation to reservation list in Booker" do
            call_book_room
            expect(booker.reservations[0]).must_be_kind_of Hotel::Reservation
            expect(booker.reservations.length).must_equal 1
        end

        it "adds new reservation to reservation list in Room" do
            expect(call_book_room.room.reservations[0]).must_be_kind_of Hotel::Reservation
            expect(call_book_room.room.reservations.length).must_equal 1
        end

        it "accruately loads the dates for the reservation" do
            expect(call_book_room.date_range).must_be_kind_of Array
            expect(call_book_room.date_range[0]).must_be_kind_of Date
        end

    end 

    describe "view_reservations method" do
        let(:call_book_room) {booker.book_room(start_date: 20190313, end_date: 20190316)}
        
        it "returns an array with all reservations on a given date" do
            call_book_room
            expect(booker.view_reservations(20190313)).must_be_kind_of Array
            expect(booker.view_reservations(20190313)[0]).must_be_kind_of Hotel::Reservation
        end

    end

    describe "available_rooms method" do
        let(:call_book_room) {booker.book_room(start_date: 20190313, end_date: 20190316)}
        
        it "returns an array with available rooms on a given date" do
            call_book_room
            expect(booker.available_rooms(20190313)).must_be_kind_of Array
            expect(booker.available_rooms(20190313)[0]).must_be_kind_of Hotel::Room
            expect(booker.available_rooms(20190313).length).must_equal 19
        end

    end

    describe "Wave 2 book_room method" do

        it "finds rooms for same requesting dates" do
            booker.book_room(start_date: 20190313, end_date: 20190316)
            booker.book_room(start_date: 20190313, end_date: 20190316)
            expect(booker.reservations.length).must_equal 2
        end

        it "finds different rooms for 5 of the same requesting dates" do
            5.times do 
                booker.book_room(start_date: 20190313, end_date: 20190316)
            end
            expect(booker.reservations.length).must_equal 5
        end

        it "error for no available rooms of the same requesting dates" do
            expect{22.times do 
                booker.book_room(start_date: 20190313, end_date: 20190316)
            end}.must_raise ArgumentError
        end



    end




end