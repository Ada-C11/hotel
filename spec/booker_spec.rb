require_relative "spec_helper.rb"

describe "Booker" do
  let(:booker) { Hotel::Booker.new }
  let(:manifest) { booker.manifest }
  before do
    room_id = 1
    day1 = Date.parse("march 20, 2020")
    day2 = Date.parse("march 28, 2020")
    @pend_reservation = Hotel::Reservation.new(check_in: day1, check_out: day2)
    @room = manifest.find_room(id: room_id)
    booker.book(reservation: @pend_reservation, room: @room)
    @reservation = @room.unavailable_list[-1]
  end
  describe "Booker#initialize" do
    it "is a type of Booker" do
      expect(booker).must_be_instance_of Hotel::Booker
    end

    it "has instance variable of type Manifest" do
      expect(manifest).must_be_instance_of Hotel::Manifest
    end
  end

  describe "Booker#book" do
    it "adds reservation to unavailable array to manifest for a given room" do
      expect(@reservation).must_be_instance_of Hotel::Reservation
    end

    it "adds reservation correctly" do
      expect(@reservation.check_in).must_equal Date.new(2020, 03, 20)
      expect(@reservation.check_out).must_equal Date.new(2020, 03, 28)
      expect(@reservation.duration_in_days).must_equal 8
      expect(@reservation.cost).must_equal 1600.0
    end

    it "adds reservation to unavailable array in correct room" do
      expect(@room.unavailable_list.include?(@pend_reservation)).must_equal true
    end

    it "raises exception if room is not available for given date range" do
      expect {
        booker.book(reservation: Hotel::Reservation.new(check_in: Date.new(2020, 03, 22), check_out: Date.new(2020, 03, 27)), room: @room)
      }.must_raise RoomNotAvailable
    end
  end

  let(:valid_block) {
    Hotel::Block.new(check_in: Date.parse("March 20, 2020"), check_out: Date.parse("March 27, 2020"), percent_discount: 15)
  }
  describe "Booker#set_up_block" do
    it "will add block to each room in rooms_collection" do
      rooms_collect = [2, 3, 5].map do |id|
        manifest.find_room(id: id)
      end
      booker.set_aside_block(block: valid_block, rooms_collection: rooms_collect)
      rooms_collect.each do |room|
        expect(room.unavailable_list[-1]).must_equal valid_block
      end
    end

    it "will raise expection if any room is unavailable before adding block to any room" do
      rooms_collect = [8, 1, 3, 4, 5].map do |id|
        manifest.find_room(id: id)
      end
      expect {
        booker.set_aside_block(block: valid_block, rooms_collection: rooms_collect)
      }.must_raise RoomNotAvailable
      rooms_collect.each do |room|
        expect(room.unavailable_list[-1]).wont_equal valid_block
      end
    end

    it "will raise exception if number of rooms requested in block is greater than 5" do
      expect {
        booker.set_aside_block(block: valid_block, rooms_collection: [7, 6, 5, 4, 3, 4].map { |id| manifest.find_room(id: id) })
      }.must_raise InvalidBlock
    end
  end

  describe "Book#book_room_associated_with_block" do
    before do
      @booker_blocks = Hotel::Booker.new
      @manifest_block = @booker_blocks.manifest
      collect_rooms = [2, 3, 5].map do |id|
        manifest.find_room(id: id)
      end
      @block = Hotel::Block.new(check_in: Time.new.to_date + 5,
                                check_out: Time.new.to_date + 10,
                                percent_discount: 15)
      @booker_blocks.set_aside_block(block: @block, rooms_collection: collect_rooms)
    end

    it "will create reservation and add it to room" do
      before_booking_reservation_from_block = Hotel::Reservation.new(check_in: Time.new.to_date + 1,
                                                                     check_out: Time.new.to_date + 4)
      room_2 = manifest.find_room(id: 2)
      @booker_blocks.book(reservation: before_booking_reservation_from_block, room: room_2)
      @booker_blocks.book_room_with_block(block: @block, room: room_2)
      expect(room_2.unavailable_list.last).wont_equal before_booking_reservation_from_block
    end

    it "will raise error if room is not part of block" do
      room_12 = manifest.find_room(id: 12)
      expect {
        @booker_blocks.book_room_with_block(block: @block, room: room_12)
      }.must_raise InvalidBlock
    end

    it "decrements number available instance variable in block " do
      before_adding_reservation_from_block = @block.number_available
      room_3 = manifest.find_room(id: 3)
      @booker_blocks.book_room_with_block(block: @block, room: room_3)
      after_adding_reservation_from_block = @block.number_available
      expect(before_adding_reservation_from_block - 1).must_equal after_adding_reservation_from_block
    end

    it "calculates cost of reservation from block correctly" do
      room_3 = manifest.find_room(id: 3)
      @booker_blocks.book_room_with_block(block: @block, room: room_3)
      expect(room_3.unavailable_list[-1].cost).must_equal 850.0
    end
  end
end
