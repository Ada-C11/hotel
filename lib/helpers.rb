module Hotel
  class Helpers

    # section of main helpers: find room id, validate date range, total nights of stay

    def self.search_room_id(list_rooms, room_id_to_search)
      return list_rooms.find { |room| room.room_id == room_id_to_search }
    end

    def self.link_room_id_with_reservation_id(list_rooms, room_id, reservation_id)
      room_id = Hotel::Helpers.search_room_id(list_rooms, room_id, reservation_id)
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
    end

    # methods to create sorted list in anticipation of binary search

    def self.sort_by_date(reservations_list)
      reservations_list.sort! { |a, b| a.check_in_date <=> b.check_in_date }
    end

    def self.sort_by_name(block_list)
      block_list.sort! { |a, b| a.first.block_name <=> b.first.block_name }
    end

    # will build out binary methods here

    def find_all_avail_rooms(check_in_date, check_out_date)
    end
  end
end
