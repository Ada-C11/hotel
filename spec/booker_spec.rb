require_relative "spec_helper"

describe "RoomBooker" do
  before do 
  @hotel = RoomBooker.new(rooms: Room.hotel_rooms)
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
    end
  end

  describe "rooms" do
    it "all items in list are an instance of Room" do
      @hotel.rooms.each do |room|
        expect(room).must_be_kind_of Room
      end
    end

    it "records room id correctly" do
      expect(@hotel.rooms.first.id).must_equal 1
      expect(@hotel.rooms.last.id).must_equal 20
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
   end

    
  #   it "will book dates that are adjacent to pre-existing dates" do
  #     pre_adj = "March 1st 2021"
  #     aligned = "March 4th 2021"
  #     @another_hotel.book_reservation(check_in: pre_adj, check_out: aligned)

  #     expect(@another_hotel.reservations.length).must_equal 21
  #   end

  #   it "will book dates that are adjacent to pre-existing dates" do
  #     post_align = "March 7th 2021"
  #     post_adj = "March 8th 2021"
  #     @another_hotel.book_reservation(check_in: post_align, check_out: post_adj)

  #     expect(@another_hotel.reservations.length).must_equal 21
  #   end
  # end

  # describe "get available rooms" do
  #   before do
  #     incoming_allowed = "March 2nd 2021"
  #     outgoing_allowed = "March 6th 2021"
  #     20.times do
  #       hotel.book_reservation(check_in: incoming_allowed, check_out: outgoing_allowed)
  #     end
  #   end

  #   it "will find rooms that are available on specific dates" do
  #     available_rooms = hotel.get_available_rooms(check_in: "March 5th", check_out: "March 6th")

  #     expect(available_rooms).must_be_kind_of Array
  #     expect(available_rooms.length).must_equal 20
  #   end

  #   it "will raise an exception for a date conflict of any kind" do
  #     going_in = "March 1st 2021"
  #     conflicts_out = "March 5th 2021"

  #     expect {
  #       hotel.get_available_rooms(check_in: going_in, check_out: conflicts_out)
  #     }.must_raise ArgumentError
  #   end
  # end

  # describe "reserve block" do
  #   let(:block_reservation) { RoomBooker.new(rooms: Room.hotel_rooms) }
  #   let(:req_date_start) { "January 20th 2020" }
  #   let(:req_date_end) { "January 23rd 2020" }

  #   it "raises an exception when trying to book more than 5 rooms" do
  #     expect {
  #       block_reservation.reserve_block(check_in: req_date_start, check_out: req_date_end, rooms_needed: 6)
  #     }.must_raise ArgumentError
  #   end

  #   it "can find and book available rooms" do
  #     successful_block = block_reservation.reserve_block(check_in: req_date_start, check_out: req_date_end, rooms_needed: 3)

  #     expect(successful_block.blocked_rooms.length).must_equal 3
  #   end

    # it "will raise an arument error for dates that are unavailable" do
    #   test_reservations = RoomBooker.new(rooms: Room.hotel_rooms)
    #   good_date_in = "March 1st 2021"
    #   good_date_out = "March 4th 2021"
    #   20.times do
    #     test_reservations.book_reservation(check_in: good_date_in, check_out: good_date_out)
    #   end

    #   tester = block_reservation.reserve_block(check_in: good_date_in, check_out: good_date_out, rooms_needed: 3)
    #   expect {
    #     block_reservation.reserve_block(check_in: good_date_in, check_out: good_date_out, rooms_needed: 3)
    #   }.must_raise ArgumentError
    # end
  end
end
