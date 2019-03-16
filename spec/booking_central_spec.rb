require 'simplecov'
require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'spec_helper'
require_relative '../lib/booking_central'

describe 'BookingCentral' do

  describe 'class setup' do
    it 'initializes 20 rooms' do
      booker = BookingCentral.new
      expect(booker.rooms.length).must_equal 20
    end

    it 'creates a new reservation' do
      booker = BookingCentral.new
      new_booking = booker.reserve_room(check_in: '2019-01-01', check_out: '2019-01-02', room: 1)
      expect(booker.all_reservations.include?(new_booking)).must_equal true
    end
  end  

  describe 'operations with reservations' do
    before do
      @booker = BookingCentral.new
      @booker.reserve_room(check_in: '2019-01-03', check_out: '2019-01-04', room: 1)
      @booker.reserve_room(check_in: '2019-01-03', check_out: '2019-01-06', room: 2)
      @booker.reserve_room(check_in: '2019-01-07', check_out: '2019-01-08', room: 3)
    end

    it 'updates array of reservations' do
      expect(@booker.all_reservations.length).must_equal 3
    end

    it 'shows reservations by date' do
      expect((@booker.reservations_by_date('2019-01-03', '2019-01-04')).length).must_equal 2
    end

    it 'returns available rooms for given date range' do
      expect((@booker.list_available_rooms('2019-01-07', '2019-01-08')).count).must_equal 19
    end
  end

  describe 'overbooking scenarios' do
    it 'does not overbook a room' do
      booker = BookingCentral.new
      new_booking = booker.reserve_room(check_in: '2019-01-03', check_out: '2019-01-04', room: 1)

      expect{(new_booking = booker.reserve_room(check_in: '2019-01-03', check_out: '2019-01-04', 
        room: assign_room(check_in, check_out)).room)}.wont_equal 1
    end

    it 'rejects hotel overbooking' do
      booker = BookingCentral.new
      expect{21.times{booker.reserve_room(check_in: '2019-01-03', check_out: '2019-01-04', 
        room: booker.assign_room('2019-01-03', '2019-01-04'))}}.must_raise ArgumentError
    end
  end

  ################ Block tests ######################

  describe 'Room Blocks' do

    it 'blocks a number of rooms' do
      @booker = BookingCentral.new
      new_block = @booker.block_rooms(
        check_in:'2019-05-01', 
        check_out: '2019-05-05', 
        number_of_rooms: 5, 
        rooms: [1, 2, 3, 4, 5], 
        discount_rate: 180)
      expect(@booker.blocks.include?(new_block)).must_equal true
    end

    it 'will block up to 5 rooms' do
      booker = BookingCentral.new
      expect{booker.block_rooms(check_in: '2019-05-01', check_out:'2019-05-04', 
        number_of_rooms: 6, rooms: [], discount_rate: 180)}.must_raise ArgumentError
    end

    it 'will only block vacant rooms' do
      booker = BookingCentral.new
      16.times{booker.reserve_room(check_in: '2019-01-03', check_out: '2019-01-04', 
        room: booker.assign_room('2019-01-03', '2019-01-04'))}

        expect{booker.block_rooms(check_in: '2019-01-03', check_out:'2019-01-04', 
          number_of_rooms: 5, rooms: [], discount_rate: 180)}.must_raise ArgumentError
    end
  end
end