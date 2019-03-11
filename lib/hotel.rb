class Hotel

  attr_reader :hotel_name, :rooms

  def initialize(hotel_name)
    @hotel_name = hotel_name
    @rooms = []
  end
  
end