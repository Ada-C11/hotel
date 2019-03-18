module Hotel
  class Helpers

    # section of main helpers: find room id, validate date range, total nights of stay

    def self.search_room_id(list_rooms, room_id_to_search)
    end

    def self.link_room_id_with_reservation_id(list_rooms, room_id, reservation_id)
    end

    def self.is_date_range_valid?(check_in_date, check_out_date)
    end

    def self.is_room_avail?(connected_room_number, check_in_date, check_out_date)
    end

    def self.nights(check_in_date, check_out_date)
    end

    # methods to create sorted list in anticipation of binary search

    def self.sort_by_date()
    end

    def self.sort_by_name()
    end

    # will build out binary methods here

    def find_all_avail_rooms(check_in_date, check_out_date)
    end
  end
end
