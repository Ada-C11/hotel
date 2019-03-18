# reservations manager spec
require_relative 'spec_helper'

describe 'Reservations Manager class' do
  let(:front_desk) { Hotel::ReservationsManager.new }

  describe 'Initialize' do
    it 'is instance of Reservations Manager' do
      front_desk.must_be_kind_of Hotel::ReservationsManager
    end

    it 'Set up for specific attribuites and data types' do
      %i[rooms reservations reservation_id].each { |prop| front_desk.must_respond_to prop }

      front_desk.rooms.must_be_kind_of Hash
      front_desk.reservations.must_be_kind_of Hash
      front_desk.reservation_id.must_be_kind_of Array
    end
  end

  describe 'List_rooms' do
    it 'displays the list of rooms in the Hotel' do
      front_desk.list_rooms.must_be_instance_of Array
      front_desk.list_rooms.each { |room| room.must_be_instance_of Hotel::Room }
    end
  end

  describe 'Makes a reservation' do
    reservation_data = {
      id: 1,
      room: Hotel::Room.new(1, 200),
      start_date: Date.parse('2019-03-17'),
      end_date: Date.parse('2019-03-27')
    }

    let(:reservation) { Hotel::Reservations.new(reservation_data) }

    it 'Reserves a room for given date range' do
      front_desk.make_reservation(1, Date.parse('2019-03-17'), Date.parse('2019-03-27')).must_be_instance_of Hotel::Reservations
    end

    it 'Adds to reservations' do
      reservation_count = front_desk.reservations.count
      front_desk.make_reservation(1, Date.parse('2019-03-17'), Date.parse('2019-03-27'))
      front_desk.make_reservation(2, Date.parse('2019-03-17'), Date.parse('2019-03-27'))
      front_desk.reservations.count.must_equal reservation_count + 2
    end

    it 'Makes a reservation on the same day another ends' do
      front_desk.make_reservation(8, Date.parse('2019-03-17'), Date.parse('2019-03-25'))
      front_desk.make_reservation(8, Date.parse('2019-03-14'), Date.parse('2019-03-17')).must_be_instance_of Hotel::Reservations
      front_desk.make_reservation(8, Date.parse('2019-03-25'), Date.parse('2019-03-30')).must_be_instance_of Hotel::Reservations
    end

    it 'Raise ArgumentError for incorrect room id' do
      proc { front_desk.make_reservation(0, Date.parse('2019-03-17'), Date.parse('2019-03-20')) }.must_raise ArgumentError
      proc { front_desk.make_reservation('21', Date.parse('2019-03-17'), Date.parse('2019-03-20')) }.must_raise ArgumentError
    end

    it 'Raise ArgumentError if room is not available' do
      front_desk.make_reservation(15, Date.parse('2019-03-18'), Date.parse('2019-03-25'))
      proc { front_desk.make_reservation(15, Date.parse('2019-03-18'), Date.parse('2019-03-25')) }.must_raise ArgumentError
    end

    it 'Raise an ArgumentError if all rooms are currently booked' do
      (1..20).each { |room| front_desk.make_reservation(room, Date.parse('2019-03-17'), Date.parse('2019-03-25')) }
      proc { front_desk.make_reservation(20, Date.parse('2019-03-18'), Date.parse('2019-03-25')) }.must_raise ArgumentError
    end
  end
  describe 'find reservation' do
    reservation_data = {
      id: 1,
      room: Hotel::Room.new(1, 200),
      start_date: Date.parse('2019-03-17'),
      end_date: Date.parse('2019-03-27')
    }

    let(:reservation) { Hotel::Reservations.new(reservation_data) }

    it 'list the reservations for specific date' do
      front_desk.make_reservation(1, Date.parse('2019-03-17'), Date.parse('2019-03-27'))
      front_desk.find_reservation(Date.parse('2019-03-17')).must_be_instance_of Array
      front_desk.find_reservation(Date.parse('2019-03-17'))[0].must_be_kind_of Hotel::Reservations
    end

    it 'Returns empty array when there are no reservations' do
      front_desk.find_reservation(Date.parse('2019-04-10')).must_be_instance_of Array
      front_desk.find_reservation(Date.parse('2019-04-10')).must_be_empty
    end
  end

  describe 'reservation total cost' do
    it 'returns the total cost for a reservation' do
      another_reservation = front_desk.make_reservation(2, Date.parse('2019-03-18'), Date.parse('2019-03-25'))
      front_desk.reservation_total_cost(another_reservation.id).must_equal 1400.00
    end
  end

  describe 'list of reserved rooms' do
    it 'returns a list of reserved rooms for given dates' do
      front_desk.make_reservation(2, Date.parse('2019-03-03'), Date.parse('2019-03-13'))
      front_desk.list_of_reservations(Date.parse('2019-03-03'), Date.parse('2019-03-13')).must_be_instance_of Array
      puts front_desk.list_of_reservations(Date.parse('2019-03-03'), Date.parse('2019-03-13')).count 1
    end

    it 'checks for multiple rooms reserved on provided dates' do
      front_desk.make_reservation(1, Date.parse('2019-03-10'), Date.parse('2019-03-13'))
      front_desk.make_reservation(2, Date.parse('2019-03-10'), Date.parse('2019-03-13'))
      front_desk.make_reservation(3, Date.parse('2019-03-10'), Date.parse('2019-03-13'))

      front_desk.list_of_reservations(Date.parse('2019-03-10'), Date.parse('2019-03-13')).must_be_instance_of Array
      front_desk.list_of_reservations(Date.parse('2019-03-10'), Date.parse('2019-03-13')).count.must_equal 3
    end
  end

  describe 'list of available rooms' do
    it 'can return a list of rooms available for given dates' do
      front_desk.make_reservation(1, Date.parse('2019-03-10'), Date.parse('2019-03-13'))
      front_desk.make_reservation(2, Date.parse('2019-03-10'), Date.parse('2019-03-13'))
      front_desk.make_reservation(3, Date.parse('2019-03-10'), Date.parse('2019-03-13'))

      front_desk.list_of_available_rooms(Date.parse('2019-03-10'), Date.parse('2019-03-13')).must_be_instance_of Array
      front_desk.list_of_available_rooms(Date.parse('2019-03-10'), Date.parse('2019-03-13')).count.must_equal 17
    end

    it 'returns all rooms when nothing is reserved' do
      all_reserved = front_desk.list_of_available_rooms(Date.parse('2019-04-10'), Date.parse('2019-04-15'))
      all_reserved.count.must_equal 20
      all_reserved.map(&:room_number).must_equal (1..20).to_a
    end
  end

  it 'returns empty when all rooms are reserved' do
    20.times do |number|
      front_desk.make_reservation(number + 1, Date.parse('2019-04-10'), Date.parse('2019-04-15'))
    end
    front_desk.list_of_available_rooms(Date.parse('2019-04-10'), Date.parse('2019-04-15')).must_be_empty
  end
end
