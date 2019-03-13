require_relative 'spec_helper'

describe "Registry class" do

  describe "initialize" do
    before do
      @report = Hotel::Registry.new
    end

    it "is an instance of registry" do
      expect(@report).must_be_kind_of Hotel::Registry
    end

    it "Has rooms and reservations" do
      expect(@report).must_respond_to :rooms
      expect(@report).must_respond_to :reservations
    end

    it "is set up for specific attributes and data types" do
      expect(@report.rooms).must_be_kind_of Array
      expect(@report.reservations).must_be_kind_of Array
    end

    it "returns an array all of the rooms in the hotel" do
      expect(@report.rooms.length).must_equal 20
    end

# ******************************************************** #
# *************TODO: TESTS I HAVEN'T WRITTEN************** #
# ******************************************************** #
# def find_by_date(date)
#   date = Date.parse(date)
#   by_date = @reservations.select do |entry|
#     entry.date.find_in_range(date)
#   end
#   by_date
# end

# def find_in_range(given_span)
#   in_range = @reservations.select do |entry|
#     entry.span.overlaps?(given_span)
#   end
#   in_range
# end
  end
end
