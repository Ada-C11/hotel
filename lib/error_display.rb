module HotelErrorDisplay
  @@errors = {
    Hotel::Error::DatePast => "You cannot reserve a date in the past.",
    Hotel::Error::RangeInvalid => "There is something wrong with your dates."
  }

  def self.message(error)
    @@errors[error.class]
  end
end