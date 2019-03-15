module Hotel
  class Days
    attr_reader :in_date, :out_date

    def initialize(in_date:, out_date:)
      @in_date = in_date
      @out_date = out_date
    end

    # def is_available?
    # end
  end
end
