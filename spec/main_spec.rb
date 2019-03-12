require_relative 'spec_helper'
require 'date'
require 'time'

describe "Class Main" do
  describe "Initialize" do
    before do
      @all_rooms = Hotel::Main.new
    end

    it "is an Array" do
      expect(@all_rooms).must_be_kind_of Array
    end

    it "has a length of 20" do
      expect(@all_rooms.length).must_equal 20
    end
  end
end