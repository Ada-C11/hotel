require_relative 'spec_helper'
require_relative '../lib/reservation'

describe Reservation do
  it 'creates a new reservation' do
    new_reservation = Reservation.new(check_in: '04-01-2019', check_out: '04-02-2019', room: 1)
    expect(new_reservation).must_be_instance_of Reservation
  end
end