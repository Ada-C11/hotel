require_relative 'spec_helper.rb'
require 'date'

describe "Reservation Manager" do
  before do
    @frontdesk = Hotel::ReservationManager.new
  end

  it "should create an instance of the reservation Manager" do
    expect(@frontdesk).must_be_instance_of Hotel::ReservationManager
  end 


  it "displays all available rooms" do
    expect(@frontdesk.hotel_rooms).must_be_instance_of(Array)
    expect(@frontdesk.hotel_rooms.first).must_equal(1)
    expect(@frontdesk.hotel_rooms[3]).must_equal(4)
    expect(@frontdesk.hotel_rooms.length).must_equal(20)
  end

  describe 'room availability method' do
    it "returns available rooms" do 
      [*1..5].each do |room|
        @frontdesk.book_reservation(room, Hotel::DateRange.new(Date.new(2019,3,15),Date.new(2019,3,18)))
      end
      expect(@frontdesk.room_availability(Date.new(2019,3,15), Date.new(2019,3,18))).must_equal([*6..20])
    end

    it "returns empty array if all rooms are booked" do
      [*1..20].each do |room|
        @frontdesk.book_reservation(room, Hotel::DateRange.new(Date.new(2019,3,15),Date.new(2019,3,18)))
      end
      expect(@frontdesk.room_availability(Date.new(2019,3,15), Date.new(2019,3,18))).must_equal([])
      expect(@frontdesk.room_availability(Date.new(2019,3,11), Date.new(2019,3,16))).must_equal([])
    end

     it "a reservation is allowed to start the same day another ends" do
#       @check_in5 = Date.new(2019,3,18)
#       @check_out5 = Date.new(2019,3,20)
#       @reservation5 = @frontdesk.book_reservation(@check_in5, @check_out5)
      
#       expect(@reservation5).must_be_kind_of(Hotel::Reservation)
    end
  end

  describe "book reservation method" do
    before do
      @test_range = Hotel::DateRange.new(Date.new(2019,3,11), Date.new(2019,3,15))
    end
     
    it "stores booked reservations in reservations array" do
      @reservations = []

      res1 = @frontdesk.book_reservation(1, @test_range)
      @reservations << res1

      expect(@reservations.length).must_equal(1)    
    end

    it "raises an error if the room is not available" do
      @frontdesk.book_reservation(1, @test_range)

      expect{@frontdesk.book_reservation(1,
          Hotel::DateRange.new(Date.new(2019,3,12), Date.new(2019,3,13)))
          }.must_raise(ArgumentError)
    end

    it 'booking a date returns an instance of reservation' do
      reservation = @frontdesk.book_reservation(1,
        Hotel::DateRange.new(Date.new(2019,3,12), Date.new(2019,3,13)))
      expect(reservation).must_be_instance_of(Hotel::Reservation)
      expect(reservation.date_range.check_in).must_equal(Date.new(2019,3,12))
      expect(reservation.date_range.check_out).must_equal(Date.new(2019,3,13))
    end
  end

  describe "search reservation by date method" do 
    before do 
      @frontdesk.book_reservation(1,
        Hotel::DateRange.new(Date.new(2019,3,5), Date.new(2019,3,9)))
      @frontdesk.book_reservation(1,
        Hotel::DateRange.new(Date.new(2019,4,11), Date.new(2019,4,12)))
      @frontdesk.book_reservation(3,
        Hotel::DateRange.new(Date.new(2019,2,5), Date.new(2019,3,8)))
      @res_list = @frontdesk.res_by_date(Date.new(2019,3,5))
    end

    it "returns the right number of reservations" do
      expect(@res_list.length).must_equal(2)
    end

    it 'returns an empty array if there are no reservations during selected date' do
      expect(@frontdesk.res_by_date(Date.new(2002,3,15))).must_be_instance_of(Array)
    end

    it "returns array of all booked reservations" do
      expect(@res_list).must_be_instance_of(Array)
      @res_list.each do |reservation|
        expect(reservation).must_be_instance_of(Hotel::Reservation)
      end
    end
  end 
  
  describe "make block reservation" do
    it "creates a block reservation" do
      block_res = @frontdesk.make_block_res([*1..5], Hotel::DateRange.new(Date.new(2019,3,11), Date.new(2019,3,18)))

      expect(block_res).must_be_instance_of(Hotel::HotelBlock)
    end

    it "adds a block reservation to blocks array" do 
      booked_blocks = @frontdesk.block_reservations.length
      @frontdesk.make_block_res([*1..5], Hotel::DateRange.new(Date.new(2019,3,11), Date.new(2019,3,18)))

      @frontdesk.make_block_res([*1..5], Hotel::DateRange.new(Date.new(2019,3,11), Date.new(2019,3,18)))
      new_block_res = @frontdesk.block_reservations.length - booked_blocks

      expect(new_block_res).must_equal(2)
    end
  end

  describe "book block reservation" do 
    it "returns an instance of a reservation"  do
      @frontdesk.make_block_res([*1..5], Hotel::DateRange.new(Date.new(2019,3,5), Date.new(2019,3,19)))

      block_reservation = @frontdesk.reserve_block(5, Hotel::DateRange.new(Date.new(2019,3,5), Date.new(2019,3,10)))

      expect(block_reservation).must_be_instance_of(Hotel::Reservation)
    end
  end

end