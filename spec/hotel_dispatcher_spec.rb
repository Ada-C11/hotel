require_relative 'spec_helper'

describe "HotelDispatcher class" do
  describe "HotelDispatcher instantiation" do
    it "is an instance of Reservation" do
      expect(Hotel::HotelDispatcher.new).must_be_kind_of Hotel::HotelDispatcher
    end
    it "returns array of all the rooms" do
      hotel = Hotel::HotelDispatcher.new
      expect(hotel.rooms).must_be_kind_of Array
    end
    it "reserves a room" do
      hotel = Hotel::HotelDispatcher.new
      expect(hotel.reserve("2019-2-23", "2019-2-25")).must_be_kind_of Hotel::Reservation
    end
  end
  describe "Room reservation" do
    before do
      @hotel = Hotel::HotelDispatcher.new
      @hotel.reserve("2019-2-21", "2019-2-26")
      @hotel.reserve("2019-2-20", "2019-2-24")
    end
    it "returns all the reservations" do
      expect(@hotel.reservations.length).must_equal 2
    end

    it "returns reservations for a specified date" do
      @hotel.reserve("2019-2-10", "2019-2-27")
      expect(@hotel.find_reservation("2019-2-23").length).must_equal 3
    end

    it "returns available rooms for a specific date" do
      @hotel.reserve("2019-2-10", "2019-2-27")
      expect(@hotel.find_available_room("2019-2-21", "2019-2-25").length).must_equal 17
    end

    it "returns ArgumentError if there are no available rooms" do
      hotel = Hotel::HotelDispatcher.new
      20.times do
      hotel.reserve("2019-2-21", "2019-2-26")
      end 
      expect do
        hotel.reserve("2019-2-21", "2019-2-26")
      end.must_raise ArgumentError
    end
  end

  describe "testing blocks" do
    before do
      @hotel = Hotel::HotelDispatcher.new
      @room_nums = [1,2,4,5]
    end

    it "returns hotel block" do
      expect(@hotel.add_block("2019-2-21", "2019-2-26", @room_nums, 150, "Ada101")).must_be_kind_of Hotel::Block
    end

    it "returns list of blocked rooms" do
      @hotel.add_block("2019-2-21", "2019-2-26", @room_nums, 150, "Ada101")
      @hotel.add_block("2019-3-1", "2019-3-8", @room_nums, 180, "Ada102")
      expect(@hotel.list_block_rooms("2019-2-27", "2019-3-7")).must_be_kind_of Array
      expect(@hotel.list_block_rooms("2019-2-21", "2019-3-7").length).must_equal 8
    end

    it "raises an ArgumentError when room is already reserved" do
      @hotel.reserve("2019-2-21", "2019-2-26")
      expect do
        @hotel.add_block("2019-2-21", "2019-2-26", @room_nums, 150, "Ada101")
      end.must_raise ArgumentError
    end

    it "raises an ArgumentError when room is already added to a block" do
      @hotel.add_block("2019-2-21", "2019-2-26", @room_nums, 150, "Ada101")
      expect do
        @hotel.add_block("2019-2-21", "2019-2-26", @room_nums, 150, "Ada102")
      end.must_raise ArgumentError
    end

    it "raises an ArgumentError when access code is already taken" do
      @hotel.add_block("2019-2-21", "2019-2-26", @room_nums, 150, "Ada101")
      expect do
        @hotel.add_block("2019-3-12", "2019-3-26", @room_nums, 150, "Ada101")
      end.must_raise ArgumentError
    end
  end

  describe "reserving from a block" do
    before do
      @hotel = Hotel::HotelDispatcher.new
      @room_nums = [1,2,4,5]
      @hotel.add_block("2019-6-20", "2019-6-24", @room_nums, 150, "DevinWedding")
    end

    it "raises an ArgumentError when access code is invalid" do
      expect do
        @hotel.reserve_from_block(2, "Ada101")
      end.must_raise ArgumentError
    end

    it "raises an ArgumentError when block room is already reserved" do
      @hotel.reserve_from_block(2, "DevinWedding")
      expect do
        @hotel.reserve_from_block(2, "DevinWedding")
      end.must_raise ArgumentError
    end

    it "raises an ArgumentError when room is not included in the block" do
      expect do
        @hotel.reserve_from_block(3, "DevinWedding")
      end.must_raise ArgumentError
    end

    it "reserves a room from a block" do
      @hotel.reserve_from_block(2, "DevinWedding")
      expect(@hotel.reservations.length).must_equal 1
      expect(@hotel.blocks["DevinWedding"].block_reservations.length).must_equal 1
    end

    it "returns availble block rooms" do
      @hotel.reserve_from_block(2, "DevinWedding")
      expect(@hotel.block_room_available?("DevinWedding").length).must_equal 3
    end
  end

end