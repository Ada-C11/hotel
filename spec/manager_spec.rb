require_relative "spec_helper.rb"

describe "Hotel Manager Setup" do
  let (:this_manager) { this_manager = Hotel::Manager.new }
  it "Make 20 rooms" do
    # p this_manager.rooms_reservations_hash
    expect(this_manager.rooms_reservations_hash.length).must_equal 20
  end

  it "List all rooms" do
    skip
    expect(this_manager.list_rooms).must_include 13
    expect(this_manager.list_rooms).wont_include 21
    expect(this_manager.list_rooms).wont_include 0
  end

  it "Add a new reservation to a room's reservations array" do
    check_in = Date.new(2019, 06, 03)
    check_out = Date.new(2019, 06, 07)
    room = 1
    new_res = this_manager.make_res_for_room(check_in, check_out, room)
    expect(this_manager.rooms_reservations_hash[1][0]).must_be_instance_of Hotel::Reservation
  end

  it "Show a list of reservations on a given date" do
    check_in1 = Date.new(2019, 06, 03)
    check_out1 = Date.new(2019, 06, 07)
    room1 = 1
    new_res1 = this_manager.make_res_for_room(check_in1, check_out1, room1)

    check_in2 = Date.new(2019, 06, 05)
    check_out2 = Date.new(2019, 06, 10)
    room2 = 8
    new_res2 = this_manager.make_res_for_room(check_in2, check_out2, room2)

    date_to_check = Date.new(2019, 06, 06)

    res_on_date = this_manager.list_reservations_for_date(date_to_check)

    expect(res_on_date[0][0]).must_equal 1
    expect(res_on_date[1][0]).must_equal 8
  end
end
