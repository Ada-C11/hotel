class Booking

  attr_reader :room_number, :cost, :availability, :date
  attr_accessor :name

  def initialize(name)
    @room_number = room_number
    @cost = cost
    @availability = availability
    @date = date
  end
end

driver = {
  DR0004: [{
    rider_id: 'RD0022',
    cost: 5,
    date: '3rd Feb 2016',
    rating: 5
  }, {
    rider_id: 'RD0022',
    cost: 10,
    date: '4th Feb 2016',
    rating: 4
  }, {
    rider_id: 'RD0073',
    cost: 20,
    date: '5th Feb 2016',
    rating: 5
  }],

  DR0001: [{
    rider_id: 'RD0003',
    cost: 10,
    date: '3rd Feb 2016',
    rating: 3
  }, {
    rider_id: 'RD0015',
    cost: 30,
    date: '3rd Feb 2016',
    rating: 4
  }, {
    rider_id: 'RD0003',
    cost: 45,
    date: '5th Feb 2016',
    rating: 2
  }],

  DR0002: [{
    rider_id: 'RD0073',
    cost: 25,
    date: '3rd Feb 2016',
    rating: 5
  }, {
    rider_id: 'RD0013',
    cost: 15,
    date: '4th Feb 2016',
    rating: 1
  }, {
    rider_id: 'RD0066',
    cost: 35,
    date: '5th Feb 2016',
    rating: 3
  }],

  DR0003: [{
    rider_id: 'RD0066',
    cost: 5,
    date: '4th Feb 2016',
    rating: 5
  }, {
    rider_id: 'RD0003',
    cost: 50,
    date: '5th Feb 2016',
    rating: 2
  }]
}