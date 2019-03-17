require_relative "spec_helper.rb"
describe "Manager Spec" do
  describe "Hotel Manager Setup" do
    let (:this_manager) { Hotel::Manager.new }
    it "Make 20 rooms" do
      # p this_manager.rooms_reservations_hash
      expect(this_manager.rooms_reservations_hash.length).must_equal 20
    end

    it "List all rooms" do
      # skip
      expect(this_manager.list_rooms).must_include 13
      expect(this_manager.list_rooms).wont_include 21
      expect(this_manager.list_rooms).wont_include 0
    end

    it "Add a new reservation to a room's reservations array" do
      check_in = Date.new(2019, 06, 03)
      check_out = Date.new(2019, 06, 07)
      room = 1
      this_manager.make_res_for_room(check_in, check_out, room)
      expect(this_manager.rooms_reservations_hash[1][0]).must_be_instance_of Hotel::Reservation
    end

    it "Show a list of reservations on a given date" do
      check_in1 = Date.new(2019, 06, 03)
      check_out1 = Date.new(2019, 06, 07)
      room1 = 1
      this_manager.make_res_for_room(check_in1, check_out1, room1)

      check_in2 = Date.new(2019, 06, 05)
      check_out2 = Date.new(2019, 06, 10)
      room2 = 8
      this_manager.make_res_for_room(check_in2, check_out2, room2)

      date_to_check = Date.new(2019, 06, 06)

      res_on_date = this_manager.list_reservations_for_date(date_to_check)

      expect(res_on_date[0][0]).must_equal 1
      expect(res_on_date[1][0]).must_equal 8
    end

    it "Sorts the array of reservations after res is made" do
      room = 1

      check_in1 = Date.new(2019, 6, 3)
      check_out1 = Date.new(2019, 6, 7)
      this_manager.make_res_for_room(check_in1, check_out1, room)

      check_in2 = Date.new(2019, 6, 8)
      check_out2 = Date.new(2019, 6, 10)
      this_manager.make_res_for_room(check_in2, check_out2, room)

      check_in3 = Date.new(2019, 6, 12)
      check_out3 = Date.new(2019, 6, 17)
      this_manager.make_res_for_room(check_in3, check_out3, room)

      #   p this_manager.rooms_reservations_hash

      expect(this_manager.rooms_reservations_hash[1][2].ckin_date.to_s).must_equal "2019-06-12"
    end
  end

  describe "Room Availability" do
    let (:this_manager) { Hotel::Manager.new }
    # generates this_manager.rooms_reservations_hash

    let (:res1) {
      check_in1 = Date.new(2019, 06, 03)
      check_out1 = Date.new(2019, 06, 07)
      room1 = 1
      this_manager.make_res_for_room(check_in1, check_out1, room1)
    }

    let (:res2) {
      check_in2 = Date.new(2019, 06, 05)
      check_out2 = Date.new(2019, 06, 10)
      room2 = 8
      res2 = this_manager.make_res_for_room(check_in2, check_out2, room2)
    }

    let (:res3) {
      check_in3 = Date.new(2019, 06, 11)
      check_out3 = Date.new(2019, 06, 12)
      room3 = 1
      res3 = this_manager.make_res_for_room(check_in3, check_out3, room3)
    }

    # let (:test_dates) {}

    it "Display a list of rooms not reserved on a given date range" do

      # ARRANGE
      this_manager
      res1
      res2
      res3
      ck_in = Date.new(2019, 6, 8)
      ck_out = Date.new(2019, 6, 9)

      # ACT
      avail_rooms = this_manager.print_available_rooms_for_dates(ck_in, ck_out)

      # ASSERT
      expect(avail_rooms).must_equal [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    end

    it "Add a new reservation to an available room's reservations array" do
      this_manager
      res1
      res2
      res3
      check_in = Date.new(2019, 6, 8)
      check_out = Date.new(2019, 6, 9)
      room = 1
      this_manager.make_res_for_room(check_in, check_out, room)
      #   binding.pry
      expect(this_manager.rooms_reservations_hash[1][1].ckout_date.to_s).must_equal "2019-06-09"
    end
  end
end
