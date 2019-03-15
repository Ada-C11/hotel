require 'pry'
module Hotel
  COST = 200
  ROOMS = [*1..20]
  class Registry
    attr_reader :reservations

    def initialize
      @reservations = []
    end

    def reserve_room(check_in, duration)
      new_res = Reservation.new(check_in, duration)

      @reservations << new_res
      @reservations
    end

    def openings(range)
      conflicts = find_in_range(range)
      open_rms = @rooms.reject do |room|
        conflicts.find do |entry|
          entry.rm_id == room[:rm_id]
        end
      end
      open_rms
    end

    def find_in_range(give_range)
      in_range = @reservations.select do |entry|
        entry.span.overlaps?(given_range)
      end
      in_range
    end

    def res_list
      @reservations.inspect
    end

    def overlaps?(reserved_dates)
      !(reserved_dates & self).empty?
    end

    def find_by_date(date)
      date = Date.parse(date)
      by_date = @reservations.select do |entry|
        entry.date.find_in_range(date)
      end
      by_date
    end
  end
end
