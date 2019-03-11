class Room

  attr_reader :number, :price

  def initialize (number)
    @number = number.to_i
    @price = 200.to_f
  end
end

room_array = []

num = 0
20.times.each do |num|
  num = Room.new(num)
  room_array.push(num)
end

puts room_array