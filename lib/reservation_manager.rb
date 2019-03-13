require_relative "reservation"
require "pry"

class ReservationManager
  attr_reader :start_date, :end_date, :make_reservation, :reservation_array, :rooms

  def initialize
    @booked_rooms = []
    @available_rooms = []
    @reservation_array = []
    @rooms = ("1".."20").to_a
  end

  def make_reservation(start_date: Date.today.to_s, end_date: (Date.today + 1).to_s, room: "0")
    @start_date = start_date
    @end_date = end_date
    @room = room
    new_reservation = Reservation.new(start_date: @start_date, end_date: @end_date, room: @room)

    date_range = new_reservation.reservation_dates
    # booked_rooms = []

    date_range[0..-2].each do |date| # excluding end date b/c you don't need a room that night
      @reservation_array.each do |reservation|
        if reservation.reservation_dates[0..-2].include?(date) #excluding end date
          @booked_rooms << reservation.room
        end
      end
    end

    if @booked_rooms.include?(new_reservation.room)
      raise ArgumentError, "That room is not availble, choose another room"
    else
      @reservation_array << new_reservation
    end

    return new_reservation
  end

  def hotel_block(start_date: Date.today.to_s, end_date: (Date.today +1).to_s, cost: 100, rooms_array: ["0"])
    start_date = start_date
    end_date = end_date
    cost = cost
    rooms_array = rooms_array
    blocked_rooms_array = []
    rooms_array.each do |room|
      @reservation_array.each do |reservation|
        if reservation.room.include?(room)
          raise ArgumentError, "A room in your desired block is booked during that time period"
        end
      end
    end
    rooms_array.each do |block_room|
      block_reservation = Reservation.new(start_date: start_date, end_date: end_date, room: block_room, cost: cost)
      blocked_rooms_array << block_reservation
    end
    return blocked_rooms_array
  end

  def view_all_rooms
    return @rooms
  end

  def access_reservations_by_date(date)
    parsed_date = Date.parse(date)
    reservations_matching_date = []
    @reservation_array.each do |reservation|
      if reservation.reservation_dates.include?(parsed_date)
        reservations_matching_date << reservation
      end
    end
    return reservations_matching_date
  end

  def view_available_rooms(start_date: Date.today, end_date: Date.today + 1) #this method should just look at booked rooms, do the work in the make reservation method above
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    date_range = (start_date..end_date).to_a

    date_range[0..-2].each do |date|
      @reservation_array.each do |reservation|
        if reservation.reservation_dates[0..-2].include?(date)
          @booked_rooms << reservation.room
        end
      end
    end
    @available_rooms = rooms - @booked_rooms
    return @available_rooms
  end
end
