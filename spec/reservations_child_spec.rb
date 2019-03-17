require_relative 'spec_helper'

describe 'Reservations class' do
  reservation_data = {
    id: 1,
    room: Hotel::Room.new(1, 200),
    start_date: Date.parse('2019-03-10'),
    end_date: Date.parse('2019-03-17')
  }

  let(:reservation) { Hotel::Reservations.new(reservation_data) }

  describe '#initialize' do
    it 'raises an ArgumentError if Start date is before End date' do
      proc {
        Hotel::Reservations.new(
          id: 1,
          room: Hotel::Room.new(1, 200),
          start_date: Date.parse('2019-03-20'),
          end_date: Date.parse('2019-03-15')
        )
      }.must_raise ArgumentError
    end

    it 'is an instance of Reservation' do
      reservation.must_be_kind_of Hotel::Reservations
    end

    it 'stores instance of room' do
      reservation.room.must_be_kind_of Hotel::Room
    end

    it 'set up for specific attribuites and data types' do
      %i[id room start_date end_date].each { |prop| reservation.must_respond_to prop }

      reservation.id.must_be_kind_of Integer
      reservation.start_date.must_be_kind_of Date
      reservation.end_date.must_be_kind_of Date
    end

  describe 'booking period' do
      it 'returns duration of reservation in days' do
        reservation.booking_period.must_equal 7
        reservation.booking_period.must_be_instance_of Integer
      end
    end

  describe 'total_cost' do
      it 'returns total cost for reservation' do
        reservation.reservation_cost.must_equal 1400
        reservation.reservation_cost.must_be_instance_of Integer
      end

      it 'does not charge for the last day' do
        short_reservation = Hotel::Reservations.new(
          id: 1,
          room: Hotel::Room.new(1, 200),
          start_date: Date.parse('2019-03-17'),
          end_date: Date.parse('2019-03-18')
        )
        short_reservation.reservation_cost.must_equal 200
      end
    end
  end
end
