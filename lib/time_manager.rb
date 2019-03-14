require 'date'
require 'pry'

module Hotel
  class TimeManager # handle durations of time for reservations 

    # create constants
    def initialize(_start_date, _end_date)
      @reservation_dates = reservation_dates(check_in, check_out)
      #reserved_period = reserved_period possibly count number of days 
    end

    # reservation dates range
    def reservation_dates(start_date, end_date)
      dates_range = (check_in(start_date)...check_out(end_date))
      return dates_range
    end


end
