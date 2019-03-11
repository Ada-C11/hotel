module Hotel
  class ReservationBooker
    attr_reader :check_in_date, :check_out_date
    def initialize(check_in_date:, check_out_date:)
      @check_in_date = check_in_date
      @check_out_date = check_out_date
    end

    # def total_cost
        

    # end
  end
end
 