require_relative "spec_helper"
require "date"
require "time"

module FrontDesk
  describe "class BlockRoom" do
    before do
      @block_room = Hotel::BlockRoom.new(
        room_booking_ref: 2001,
        block_room_number: 3,
        check_in: Date.new(2019, 5, 20),
        check_out: Date.new(2019, 5, 24),
      )
    end # before block

    it "creates an instance of BlockRoom" do
      expect(@block_room).must_be_kind_of Hotel::BlockRoom
    end
  end
end
