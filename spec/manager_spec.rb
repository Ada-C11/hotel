require_relative "spec_helper"
describe "Manager Class" do
  before do
    room_num = 5
    check_in = Date.parse("2019-05-14")
    check_out = Date.parse("2019-05-18")
    rooms = []
    rooms << Room.new(id: 1)
    rooms << Room.new(id: 2)
    rooms << Room.new(id: 3)

    @reservation1_data = {
      room_num: 5,
      check_in: check_in.to_s,
      check_out: check_out.to_s,
      rooms: rooms,

    }
    @reservation2_data = {
      room_num: 7,
      check_in: Date.parse("2019-06-02").to_s,
      check_out: Date.parse("2019-06-04").to_s,
      rooms: rooms,
    }
    @reservation1 = Reservation.new(@reservation1_data)
    @reservation2 = Reservation.new(@reservation2_data)
    @manager = Manager.new
  end
  it "is an instance of Manager" do
    expect(@manager).must_be_kind_of Manager
  end
end
