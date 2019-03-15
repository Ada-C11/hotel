require "date"
require_relative "spec_helper"

describe "Frontdesk.new" do
  before do
    @frontdesk = Hotel::Frontdesk.new
  end
  it "creates and instance of Frontdesk" do
    expect(@frontdesk).must_be_instance_of Hotel::Frontdesk
  end

  it "creates a list of 20 rooms at the hotel" do
    expect(@frontdesk.rooms).must_be_instance_of Array
    expect(@frontdesk.rooms.length).must_equal 20
    expect(@frontdesk.rooms.first.number).must_equal 1
    expect(@frontdesk.rooms.last.number).must_equal 20
  end
end

describe "Frontdesk request_reservation" do
  before do
    @frontdesk = Hotel::Frontdesk.new
    @reservation = Hotel::Reservation.new("Agatha Christie", "2019-05-20", 2)
    @frontdesk.request_reservation(@reservation)
  end
  it "adds reservation to reservation list" do
    expect(@frontdesk.reservations[0]).must_be_instance_of Hotel::Reservation
  end
  it "assigns an available room to the reservation" do
    expect(@reservation.room_num).must_be_instance_of Integer
  end
  it "raises and argument error if no rooms are available for that date" do
    reservation_2 = Hotel::Reservation.new("Agatha Christie", "2019-05-20", 2)
    expect {
      20.times do
        @frontdesk.request_reservation(reservation_2)
      end
    }.must_raise ArgumentError
  end
end

describe "Frontdesk request_reservation with block_reference" do
  before do
    @frontdesk = Hotel::Frontdesk.new
    @block_res = Hotel::Reservation.new("Octavia Butler", "2019-07-08", 3, block_reference: "SCIFI PARTY")
    @frontdesk.request_block(@block_res, 5)
    @reservation3 = Hotel::Reservation.new("Amy Martinsen", "2019-07-08", 3, block_reference: "SCIFI PARTY")
    @frontdesk.request_reservation(@reservation3)
    @reservation4 = Hotel::Reservation.new("Mollie Bullis", "2019-07-08", 2, block_reference: "SCIFI PARTY")
  end
  it "adjusts the reservation cost based on blocked status" do
    expect(@block_res.cost).must_equal 450
  end
  it "changes reservations block status to :UNAVAILABLE" do
    expect(@reservation3.block_availability).must_equal :UNAVAILABLE
  end
  it "returns ArgumentError if block reservation doesn't have the correct dates" do
    expect { @frontdesk.request_reservation(@reservation4) }.must_raise ArgumentError
  end
end

describe "Frontdesk find_reservation_by_date" do
  before do
    @frontdesk = Hotel::Frontdesk.new
    reservation = Hotel::Reservation.new("Agatha Christie", "2019-05-20", 2)
    reservation2 = Hotel::Reservation.new("Nnedi Okorafor", "2018-05-20", 2)
    @frontdesk.request_reservation(reservation)
    @frontdesk.request_reservation(reservation2)
  end
  it "returns a list of reservations by date" do
    known_reservation = @frontdesk.find_reservation_by_date("2019-05-20")
    no_reservations = @frontdesk.find_reservation_by_date("2017-05-20")
    expect(known_reservation).must_be_instance_of Array
    expect(known_reservation[0]).must_be_instance_of Hotel::Reservation
    expect(known_reservation[0].name).must_equal "Agatha Christie"
    expect(no_reservations).must_be_nil
  end
end

describe "Frontdesk find_available_rooms" do
  before do
    @frontdesk = Hotel::Frontdesk.new
    pending_res1 = Hotel::Reservation.new("Agatha Christie", "2019-05-20", 2)
    pending_res2 = Hotel::Reservation.new("Nnedi Okorafor", "2019-05-20", 2)
    @reservation1 = @frontdesk.request_reservation(pending_res1)
    @reservation2 = @frontdesk.request_reservation(pending_res2)
  end
  it "returns an array of available rooms" do
    dates = @reservation1.reserved_nights
    available_rooms = @frontdesk.find_available_rooms(dates)
    expect(available_rooms).must_be_instance_of Array
    expect(available_rooms[0]).must_be_instance_of Hotel::Room
    expect(available_rooms.length).must_equal 18
  end
  it "returns an empty array if no available rooms" do
    reservation3 = Hotel::Reservation.new("Agatha Christie", "2019-05-20", 2)
    18.times do
      @frontdesk.request_reservation(reservation3)
    end
    dates = reservation3.reserved_nights
    expect (@frontdesk.find_available_rooms(dates)).must_equal []
  end
end

describe "Frontdesk request_block" do
  before do
    @frontdesk = Hotel::Frontdesk.new
    @block_res = Hotel::Reservation.new("Ursula Le Guin", "2019-07-08", 3, block_reference: "WIZARD PARTY")
    @blocked_rooms = @frontdesk.request_block(@block_res, 5)
    @dates = @block_res.reserved_nights
  end
  it "reserves a block of rooms" do
    date = (@dates[0]).to_s
    expect(@blocked_rooms).must_be_instance_of Array
    expect(@blocked_rooms[2]).must_be_instance_of Hotel::Reservation
    expect(@blocked_rooms.length).must_equal 5
    expect(@frontdesk.find_available_rooms(@dates).length).must_equal 15
    expect(@frontdesk.find_reservation_by_date(date).length).must_equal 5
    expect(@frontdesk.block_reservations.length).must_equal 1
    expect(@block_res.block_reference).must_equal "WIZARD PARTY"
    expect(@blocked_rooms[0].block_availability).must_equal :AVAILABLE
  end
  it "raises an ArgumentError when user requests more than 5 rooms" do
    expect { @frontdesk.request_block(@block_res, 6) }.must_raise ArgumentError
  end
  it "raises an ArgumentError when no rooms are available" do
    block_res_2 = Hotel::Reservation.new("Octavia Butler", "2019-07-08", 3, block_reference: "SCIFI PARTY")
    block_res_3 = Hotel::Reservation.new("Agatha Christie", "2019-07-08", 3, block_reference: "MYSTERY PARTY")
    block_res_4 = Hotel::Reservation.new("Sally Rooney", "2019-07-08", 3, block_reference: "FICTION PARTY")
    block_res_5 = Hotel::Reservation.new("Leni Zumas", "2019-07-08", 3, block_reference: "SPECFIC PARTY")
    @frontdesk.request_block(block_res_2, 5)
    @frontdesk.request_block(block_res_3, 5)
    @frontdesk.request_block(block_res_4, 3)
    expect(@frontdesk.block_reservations.length).must_equal 4
    expect { @frontdesk.request_block(block_res_5, 3) }.must_raise ArgumentError
  end
end

describe "find_available_block_rooms" do
  before do
    @frontdesk = Hotel::Frontdesk.new
    @block_res = Hotel::Reservation.new("Ursula Le Guin", "2019-07-08", 3, block_reference: "WIZARD PARTY")
    @blocked_rooms = @frontdesk.request_block(@block_res, 5)
    @block_res2 = Hotel::Reservation.new("Amy Martinsen", "2019-07-08", 3, block_reference: "WIZARD PARTY")
    @frontdesk.request_reservation(@block_res2)
  end
  it "returns only available rooms in the block" do
    expect(@frontdesk.find_available_block_rooms("WIZARD PARTY")).must_be_instance_of Array
    expect(@frontdesk.find_available_block_rooms("WIZARD PARTY").length).must_equal 4
  end
  it "raises an ArgumentError if block reference doesn't exist" do
    expect { @frontdesk.find_available_block_rooms("DRAGON PARTY") }.must_raise ArgumentError
  end
end
