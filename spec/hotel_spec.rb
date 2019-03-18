require_relative 'spec_helper'

describe "hotel" do
  NUM_BOOKED_ROOMS = Hotel::NUM_ROOMS - 5

  before do
    @seventh = Time.parse("2018-07-07")
    @eleventh = Time.parse("2018-07-11")
  end

  let(:empty_hotel) do
    empty_hotel = Hotel.new
  end

  let(:booked_hotel) do
    booked_hotel = Hotel.new
    (NUM_BOOKED_ROOMS).times do
      booked_hotel.make_reservation(@seventh, @eleventh)
    end
    booked_hotel
  end

  let(:fully_booked_hotel) do
    fully_booked_hotel = Hotel.new
    Hotel::NUM_ROOMS.times do
      fully_booked_hotel.make_reservation(@seventh, @eleventh)
    end
    fully_booked_hotel
  end

  it "get rooms" do
    rooms = empty_hotel.get_rooms
    expect(rooms.length).must_equal Hotel::NUM_ROOMS
  end

  describe "makes reservation" do
    it "make reservation for hotel with no reservations" do
      reservation = empty_hotel.make_reservation(@seventh, @eleventh)
    end

    it "make reservation for hotel with several reservations" do
      reservation = booked_hotel.make_reservation(@seventh, @eleventh)
    end

    it "make reservation for fully booked hotel" do
      expect{fully_booked_hotel.make_reservation(@seventh, @eleventh)}.must_raise RuntimeError
    end

    it "make reservation with invalid dates" do
      expect{fully_booked_hotel.make_reservation(@eleventh, @seventh)}.must_raise ArgumentError
    end
  end

  describe "finds available rooms" do
    it "find available rooms when some are available" do
      available_rooms = booked_hotel.find_available_rooms(@seventh, @eleventh)
      expect(available_rooms.length).must_equal Hotel::NUM_ROOMS - NUM_BOOKED_ROOMS
    end

    it "find available rooms when none are available" do
      available_rooms = fully_booked_hotel.find_available_rooms(@seventh, @eleventh)
      expect(available_rooms.empty?).must_equal true
    end
  end

  it "get reservations inclusive" do
    inclusive_reservations = booked_hotel.get_reservations_inclusive(@eleventh)
    expect(inclusive_reservations.length).must_equal NUM_BOOKED_ROOMS
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
