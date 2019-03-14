module Scheduler
  ALL_ROOMS = Array.new
  ALL_RESERVATIONS = Array.new

  def self.load_schedule

  end

  def self.load_all_rooms
    ALL_ROOMS.clear
    for i in 1..20 do
      ALL_ROOMS << Room.new(i)
    end
  end

  def self.list_reservations(date)
    list = Array.new
    ALL_RESERVATIONS.each do |reservation|
      if reservation.includes_date?(date)
        list << reservation
      end
    end
    return list
  end

  def self.make_reservation(time_interval)
    room_id = self.find_available_room(time_interval)
    if room_id == nil
      raise ArgumentError, "There are no available rooms"
    end

    new_reservation = Reservation.new(time_interval)
    ALL_ROOMS.each do |room|
      if room.id == room_id
        ALL_RESERVATIONS << new_reservation
        room.reserve(time_interval)
      end
    end
  end

  def self.generate_bill(reservation)
    return reservation.get_total_cost
  end

  def self.list_available_rooms(time_interval)
    list = Array.new
    ALL_ROOMS.each do |room|
      room.bookings.each do |booking|
        if !booking.overlap?(time_interval)
          list << room.id
        end
      end
    end

    return list
  end

  def self.find_available_room(time_interval)
    ALL_ROOMS.each do |room|
      if !room.overlap?(time_interval)
        return room.id
      end
    end

    return nil
  end
end