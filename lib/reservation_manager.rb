require_relative "reservation"
require "pry"

class ReservationManager
  attr_reader :reservation_array, :rooms

  def initialize
    @booked_rooms = []
    @available_rooms = []
    @reservation_array = []
    @blocked_rooms_array = []
    @blocked_reservation_array = []
    @rooms = ("1".."20").to_a
  end

  def make_reservation(start_date: Date.today.to_s, end_date: (Date.today + 1).to_s, room: "0", cost: 200)
    new_reservation = Reservation.new(start_date: start_date, end_date: end_date, room: room, cost: cost)
    check_res = view_available_rooms(start_date: new_reservation.start_date, end_date: new_reservation.end_date)

    if !check_res.include?(new_reservation.room)
      raise ArgumentError, "That room is not available, choose another room"
    elsif @blocked_rooms_array.include?(new_reservation.room) && new_reservation.cost == 200
      #don't allow block to be booked unless they are part of that block (cost would be less) #adjust to make sure they book the exact blocked duration
      raise ArgumentError, "That room is blocked, choose another room"
    elsif new_reservation.cost < 200 && @blocked_reservation_array.first.start_date == new_reservation.start_date && @blocked_reservation_array.first.end_date == new_reservation.end_date
      @reservation_array << new_reservation #test this code
    elsif new_reservation.cost < 200 && (@blocked_reservation_array.first.start_date != new_reservation.start_date || @blocked_reservation_array.first.end_date == new_reservation.end_date)
      raise ArgumentError, "If you are booking the hotel block, you must book the entire date range"
    else
      @reservation_array << new_reservation
    end

    return new_reservation
  end

  # need this code, not sure where to use it @blocked_reservation_array.each { |reservation| reservation.reservation_dates == new_reservation.reservation_dates }
  def hotel_block(start_date: Date.today.to_s, end_date: (Date.today + 1).to_s, cost: 100, rooms_array: ["0"])
    start_date = start_date
    end_date = end_date
    cost = cost
    rooms_array = rooms_array

    rooms_array.each do |room|
      @reservation_array.each do |reservation|
        reservation.reservation_dates[0..-2].each do |date|
          if (Date.parse(start_date)..Date.parse(end_date)).to_a[0..-2].include?(date) && reservation.room.include?(room)
            raise ArgumentError, "A room in your desired block is booked during that time period"
          end
        end
      end

      @blocked_reservation_array.each do |blocked_reservation|
        blocked_reservation.reservation_dates[0..-2].each do |date|
          if (Date.parse(start_date)..Date.parse(end_date)).to_a[0..-2].include?(date) && blocked_reservation.room.include?(room)
            raise ArgumentError, "There is already a block on that date or room during your block duration."
          end
        end
      end
    end

    rooms_array.each do |block_room|
      block_reservation = Reservation.new(start_date: start_date, end_date: end_date, room: block_room, cost: cost)
      @blocked_rooms_array << block_reservation.room
      @blocked_reservation_array << block_reservation
    end

    return @blocked_rooms_array
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

  def view_available_rooms(start_date: Date.today.to_s, end_date: (Date.today + 1).to_s) #this method should just look at booked rooms, do the work in the make reservation method above
    #make this look at blocked rooms too
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    date_range = (start_date..end_date).to_a

    # check for rooms not reserved
    date_range[0..-2].each do |date|
      @reservation_array.each do |reservation|
        if reservation.reservation_dates[0..-2].include?(date)
          @booked_rooms << reservation.room
        end
      end
    end

    # # check for rooms not blocked
    # date_range[0..2].each do |date|
    #   @blocked_reservation_array.each do |reservation|
    #     if reservation.reservation_dates[0..-2].include?(date)
    #       @booked_rooms << reservation.room
    #     end
    #   end
    # end

    @available_rooms = rooms - @booked_rooms
    return @available_rooms
  end
end
