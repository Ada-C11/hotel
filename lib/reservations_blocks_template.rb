
class RandBTemplate
  attr_reader :activity

  def activity(activity)
    @activity = activity
    puts @activity
  end

  def rooms
    @rooms = (1..20).to_a
    return @rooms
  end

  def validate_date_range(start_date, end_date)
    if start_date > end_date
      raise ArgumentError, "Invalid date range"
    else
      @start_date = start_date
      @end_date = end_date
    end
  end

  def validate_room_availability(start_date, end_date, room_selected)
    begin
      rooms_available = find_available_rooms(start_date, end_date)
    rescue ArgumentError
      if rooms.include?(room_selected)
        room = room_selected
        return room
      else
        raise ArgumentError, "The room number is not valid"
      end
    else
      if rooms_available.include?(room_selected)
        room = room_selected
        return room
      else
        raise ArgumentError, "The room number is not available"
      end
    end
  end

  def find_available_rooms(start_date, end_date)
    blocks = find_by_date(start_date, end_date)

    rooms_in_blocks = []
    blocks.each do |block|
      rooms_in_blocks << block.room
    end

    return available_rooms(rooms_in_blocks)
  end

  def available_rooms(rooms_in_blocks)
    available_rooms = rooms
    rooms_in_blocks.each do |rooms_block|
      available_rooms -= rooms_block
    end
    return available_rooms
  end

  def find_by_date(start_date_find, end_date_find)
    if start_date_find.class == Time && end_date_find.class == Time
      found = []
      @activity.each do |reservation|
        unless reservation.start_date >= end_date_find || reservation.end_date <= start_date_find
          found << reservation
        end
      end

      if found.empty?
        raise ArgumentError, "There are no reservations for that date"
      else
        return found
      end
    end
  end

  def find_by_id(id)
    index = 0
    if id.class == Integer
      @activity.find do |reservation|
        if reservation.id == id
          return reservation
        end
      end
      raise ArgumentError, "Invalid reservation id"
    end
  end
end
