require_relative 'spec_helper'

describe 'Room class' do
  describe 'initalize' do
    before do
      @room = HotelSystem::Room.new
    end

    it "is an instance of a room" do
      expect(@room).must_be_kind_of HotelSystem::Room
    end
  end
end