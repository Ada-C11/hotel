require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'spec_helper'
require_relative '../lib/block'

describe 'Block' do
  it 'blocks a number of rooms' do
    @booker = BookingCentral.new
    new_block = Block.new(check_in:'2019-05-01', check_out: '2019-05-05', number_of_rooms: 5, rooms: [1, 2, 3, 4, 5], discount_rate: 180)
    expect(new_block.rooms.count).must_equal 5

  end
end