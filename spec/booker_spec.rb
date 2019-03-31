require_relative "spec_helper"

describe "RoomBooker" do
  before do 
  @hotel = RoomBooker.new
  end

  describe "instantiation" do
    it "creates an instance of RoomBooker" do
      expect(@hotel).must_be_kind_of RoomBooker
    end

    it "creates a list of all 20 rooms" do
      expect(@hotel.rooms).must_be_kind_of Array
    end
    it "creates a list of reservations" do
      expect(@hotel.reservations).must_be_kind_of Array
    end

    it "tracks reservations, rooms and room rate" do 
      @hotel.must_respond_to :reservations
      @hotel.must_respond_to :rooms
      @hotel.must_respond_to :rate
    end
  end

  describe "book_reservation" do
    before do 
      @checkin = Date.new(2020, 10, 01)
      @checkout = Date.new(2020, 10, 05)
    end

   it "raises an error for an unavailable room" do 
    room = 3
     @hotel.book_reservation(3, @checkin, @checkout)

     expect{
       @hotel.book_reservation(3, @checkin, @checkout)
     }.must_raise RoomBooker::NotReservableError
   end

   it "returns a booked reservation" do 
    reservation = @hotel.book_reservation(2, @checkin, @checkout)

    expect(reservation).must_be_kind_of Reservation
    expect(reservation.check_in).must_equal @checkin
    expect(reservation.check_out).must_equal @checkout

    expect(@hotel.reservations).must_include reservation
   end
  end
  describe "list reservations" do 
    before do 
      @date = Date.new(2019, 10, 01)
    end

    it "includes reservations for that date" do
      @hotel.book_reservation(12, @date-2, @date+2)
      
      expect(@hotel.list_reservations(@date).length).must_equal 1
    end

    it "returns an empty array with no reservations on that date" do
      @hotel.book_reservation(12, @date+2, @date+4)

      expect(@hotel.list_reservations(@date).length).must_equal 0
    end

    it "returns an empty list if no reservations for that date" do
      expect(@hotel.reservations.length).must_equal 0
      expect(@hotel.list_reservations(@date).length).must_equal 0
    end
  end

  describe "find available room" do 
    before do 
      @date = Date.parse("October 12 2019")
    end
    
    it "shows all rooms available if nothing is reserved already" do 
      all_rooms = @hotel.rooms
      
      expect(@hotel.find_available_room(@date, @date+1)).must_equal all_rooms
    end

    it "returns only rooms not booked for given date range" do 
      room = 1
      @hotel.book_reservation(room, @date-2, @date+2)
      
      expect(@hotel.find_available_room(@date, @date+1)).must_equal (@hotel.rooms - [room])
    end

    it "will show full availability for a non-overlapping reservation" do 
      all_rooms = @hotel.rooms
      room = 1
      @hotel.book_reservation(room, @date-6, @date-4)

      expect(@hotel.find_available_room(@date, @date+1)).must_equal all_rooms
    end
  end
end