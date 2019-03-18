require_relative 'spec_helper'

describe "hotel" do
  before do
    @seventh = Time.parse("2018-07-07")
    @eleventh = Time.parse("2018-07-11")
  end

  let(:empty_hotel) do
    empty_hotel = Hotel.new
  end

  let(:booked_hotel) do
    booked_hotel = Hotel.new
    (Hotel::NUM_ROOMS - 5).times do
      booked_hotel.make_reservation(@seventh, @eleventh)
    end
  end

  let(:fully_booked_hotel) do
    fully_booked_hotel = Hotel.new
    Hotel::NUM_ROOMS.times do
      fully_booked_hotel.make_reservation(@seventh, @eleventh)
    end
  end

  it "get rooms" do
    rooms = empty_hotel.get_rooms
    expect(rooms.length).must_equal Hotel::NUM_ROOMS
  end

  describe "makes reservation" do
    it "make reservation for hotel with no reservations" do

    end

    it "make reservation for hotel with several reservations" do

    end

    it "make reservation for fully booked hotel" do

    end

    it "make reservation with invalid dates" do

    end
  end

  describe "finds available rooms" do
    it "find available rooms when some are available" do

    end

    it "find available rooms when none are available" do

    end
  end

  it "get reservations inclusive" do
    # gets a reservation that is inclusive
    #make a hotel that has reservations

  end

  describe 'validate date range' do
    it 'invalid date range throws exception' do
      expect{empty_hotel.validate_date_range(@eleventh, @seventh)}.must_raise ArgumentError
    end

    it "valid date range throws no exception" do
      empty_hotel.validate_date_range(@seventh, @eleventh)
    end
  end
end
