module Hotel
  class Room
    attr_reader :id, :cost, :reservations, :block

    def initialize(id:, cost: 200, reservations: nil, block: nil)
      @id = id
      @cost = cost
      raise ArgumentError, "Cost not valid" if cost.nil? || cost / 1 < 0
      @reservations ||= []
      @block ||= []
    end

    def add_reservation(reservation)
      reservations << reservation
    end

    def add_block(hotel_block)
      block << hotel_block
    end

    def isAvailable?(start_date, end_date)
      return check_date_range_conflict(start_date, end_date, reservations) &&
               check_date_range_conflict(start_date, end_date, block)
    end

    def check_date_range_conflict(start_date, end_date, array)
      if array != []
        array.each do |item|
          return true if (!(item.start_date...item.end_date).include?(start_date) &&
                          !(item.start_date + 1..item.end_date).include?(end_date) &&
                          !(start_date...end_date).include?(item.start_date) &&
                          !((start_date + 1)..end_date).include?(item.end_date))
        end
        return false
      else
        return true
      end
    end
  end
end
