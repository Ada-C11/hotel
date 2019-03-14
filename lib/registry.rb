require 'pry'
module Hotel

  class Registry
    attr_reader :rooms, :reservations

    def initialize
      @rooms = (1..20)
      @reservations = []
    end

    def reserve_room(input)
      dates = [input[:check_in], input[:check_out]]
      room = openings(dates).first || []
      reservation_data = {
        room: room,
        span: (dates[0..1])
      }

      new_res = Reservation.new(reservation_data)
      @reservations << new_res
      @reservations
    end

    def openings(span)
      conflicts = find_in_range(span)
      open_rms = @rooms.reject do |room|
        conflicts.find do |entry|
          entry.rm_id == room[:rm_id]
        end
      end
      open_rms
    end

    def res_list
      binding.pry
      @reservations.inspect
    end

    def find_by_date(date)
      date = Date.parse(date)
      by_date = @reservations.select do |entry|
        entry.date.find_in_range(date)
      end
      by_date
    end

    def find_in_range(given_span)
      in_range = @reservations.select do |entry|
        entry.span.overlaps?(given_span)
      end
      in_range
    end
  end
end
