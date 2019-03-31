require "date"

require_relative "room"
require_relative "reservation"
require_relative "block"
require_relative "block_reservation"

module HotelSystem
  class Hotel
    attr_reader :reservations, :blocks, :id
    attr_accessor :rooms

    def initialize(id:, rooms: [])
      @id = id
      @rooms = HotelSystem::Room.create_rooms(rooms)
      @reservations = []
      @blocks = []
    end

    def list_rooms
      room_list = @rooms.map { |room| room.id }
      return room_list
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def create_date_object(date)
      date_object = Date.parse(date)
      return date_object
    end

    def create_reservation(room, arrive_day, depart_day)
      reservation = HotelSystem::Reservation.new(room: room, arrive_day: arrive_day, depart_day: depart_day)
      return reservation
    end

    def book_reservation(room, arrive, depart)
      arrive_day = create_date_object(arrive)
      depart_day = create_date_object(depart)
      (arrive_day...depart_day).each do |day|
        raise ArgumentError, "Room not avaiable for that date" if !is_room_availabile?(room, day)
      end
      reservation = create_reservation(room, arrive_day, depart_day)
      add_reservation(reservation)
      room.add_reservation(reservation)
      return reservation
    end

    def is_room_availabile?(room, date)
      return room.available?(date)
    end

    def reservations_by_date(date)
      date_object = create_date_object(date)
      reservations_on_date = @reservations.select { |res| res.include?(date_object) }
      reservations_on_date.reject! do |res|
        res if res.class == HotelSystem::BlockReservation && res.status == :AVAILABLE
      end
      return reservations_on_date
    end

    def get_available_rooms(arrive_day, depart_day)
      available_rooms = @rooms.clone
      (arrive_day...depart_day).each do |day|
        date_obj = create_date_object(day)
        available_rooms.reject! { |room| is_room_availabile?(room, date_obj) == false }
      end
      return available_rooms
    end

    def create_block(rooms, arrive_day, depart_day, discount)
      new_block = HotelSystem::Block.new(rooms: rooms, arrive_day: create_date_object(arrive_day), depart_day: create_date_object(depart_day), discount: discount)
      new_block.reservations.each do |reservation|
        add_reservation(reservation)
      end
      @blocks << new_block
      return new_block
    end
  end
end
