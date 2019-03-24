module Hotel
  class DateRange
    def initialize(check_in_date, check_out_date)
      self.class.validate_date(check_in_date)
      self.class.validate_date(check_out_date)
      validate_date_range(check_in_date, check_out_date)
    end

    def self.validate_date(date)
      raise ArgumentError, "Date cannot be nil" if date == nil
      raise ArgumentError, "Date must be a String" if date.class != String
      raise ArgumentError, "Date must be in the format yyyy-mm-dd" if date !~ /^(\d{4})\-(\d{1,2})\-(\d{1,2})$/
      groups = date.match(/^(\d{4})\-(\d{1,2})\-(\d{1,2})$/)
      raise ArgumentError, "Month cannot be larger than 12" if groups[2].to_i > 12
      raise ArgumentError, "Day cannot be larger than 31" if groups[3].to_i > 31
      return Date.parse(date)
    end

    def validate_date_range(start_date, end_date)
      raise ArgumentError, "Check_out_date must be after check_in_date" if end_date < start_date
    end

    def self.get_na_objects(array_object, check_in_date_string, check_out_date_string)
      check_in_date = self.validate_date(check_in_date_string)
      check_out_date = self.validate_date(check_out_date_string)
      return array = array_object.select do |object|
               check_in_date < object.check_out_date && check_in_date >= object.check_in_date ||
               check_out_date > object.check_in_date && check_out_date < object.check_out_date ||
               check_in_date < object.check_in_date && check_out_date > object.check_out_date
             end
    end
  end
end
