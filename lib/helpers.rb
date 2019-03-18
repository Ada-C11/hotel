module Hotel
  class Helpers

    # section of main helpers: find room id, validate date range, total nights of stay

    def self.search_room_id(see_rooms, room_id_to_search)
      return see_rooms.find { |room| room.room_id == room_id_to_search }
    end

    def self.link_room_id_with_reservation_id(see_rooms, room_id, reservation_id)
      room_id = Hotel::Helpers.search_room_id(see_rooms, room_id, reservation_id)
      if Hotel::Helpers.is_room_avail? == :RESERVED
        return raise ArgumentError, "So sorry! There are no available rooms for your requested dates."
      end
      connected_room_number.reservations << reservation
      Hotel::Helpers.sort_by_date(connected_room_number.reservations)
    end

    def self.is_date_range_valid?(check_in_date, check_out_date)
      if check_out_date < check_in_date || check_out_date == nil || check_in_date == nil
        return raise StandardError, "Date range is invalid."
      end
    end

    def self.is_room_avail?(connected_room_number, check_in_date, check_out_date)
      possible_stay = Hotel::Helpers.nights(check_in_date, check_out_date)
      if Hotel::Helpers.find_all_avail_rooms(connected_room_number.reservations, possible_stay) == true
        return :RESERVED
      else
        return :AVAILABLE
      end
    end

    def self.nights(check_in_date, check_out_date)
      nights_stay = []
      num_nights = (check_out_date - check_in_date)
      num_nights.to_i.times do |x|
        night = check_in_date + x
        nights_stay << night
      end
      return nights_stay
    end

    # methods to create sorted list in anticipation of binary search

    def self.sort_by_date(reservations_list)
      reservations_list.sort! { |a, b| a.check_in_date <=> b.check_in_date }
    end

    def self.sort_by_name(block_list)
      block_list.sort! { |a, b| a.first.block_name <=> b.first.block_name }
    end

    # FIX - there is a bug somewhere in this method
    def find_all_avail_rooms(check_in_date, check_out_date)
      requested_dates = (check_in_date...check_out_date).to_a
      max = reservations_array.length

      if reservations_array.first == nil
        return false
      end

      while min < max
        mid = (min + max) / 2
        if !(requested_dates & reservations_array[mid].nights_stay).empty?
          return true
        elsif reservations_array[mid].check_in_date > requested_dates.first
          max = mid - 1
        elsif reservations_array[mid].check_in_date < requested_dates.first
          min = mid + 1
        end
      end

      if !(requested_dates & reservations_array[0].nights_stay).empty?
        return true
      end

      return false
    end
  end

  # binary

  # FIX - there is a bug somewhere in this method
  def self.binary_search_for_avail_room(reservations_array, requested_dates)
    # returns false if the room is unreserved/available
    min = 0
    max = reservations_array.length

    if reservations_array.first == nil
      return false
    end

    while min < max
      mid = (min + max) / 2
      if !(requested_dates & reservations_array[mid].nights_of_stay).empty?
        return true
      elsif reservations_array[mid].check_in_date > requested_dates.first
        max = mid - 1
      elsif reservations_array[mid].check_in_date < requested_dates.first
        min = mid + 1
      end
    end

    if !(requested_dates & reservations_array[0].nights_of_stay).empty?
      return true
    end

    return false
  end

  def self.binary_search_for_reservations_by_date(reservations_array, date)
    # returns nil if no reservation exists on that date
    min = 0
    max = reservations_array.length

    if reservations_array.first == nil
      return nil
    end

    while min < max
      mid = (min + max) / 2
      if reservations_array[mid].nights_stay.include?(date)
        return mid
      elsif reservations_array[mid].check_in_date > date
        max = mid - 1
      elsif reservations_array[mid].check_in_date < date
        min = mid + 1
      end
    end

    if reservations_array[0].nights_stay.include?(date)
      return 0
    end

    return nil
  end
end
