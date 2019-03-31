require_relative "spec_helper.rb"
describe "Manager Spec" do
  describe "Hotel Manager Setup" do
    let (:this_manager) { Hotel::Manager.new }
    it "Make 20 rooms" do
      # p this_manager.rooms_reservations_hash
      expect(this_manager.rooms_reservations_hash.length).must_equal 20
    end

    it "List all rooms" do
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

    it "Access a list of reservations on a given date" do
      check_in1 = Date.new(2019, 06, 03)
      check_out1 = Date.new(2019, 06, 07)
      room1 = 1
      this_manager.make_res_for_room(check_in1, check_out1, room1)

      check_in2 = Date.new(2019, 06, 05)
      check_out2 = Date.new(2019, 06, 10)
      room8 = 8
      this_manager.make_res_for_room(check_in2, check_out2, room8)

      check_in3 = Date.new(2019, 06, 7)
      check_out3 = Date.new(2019, 06, 11)
      this_manager.make_res_for_room(check_in3, check_out3, room1)

      check_in3 = Date.new(2019, 06, 07)
      check_out3 = Date.new(2019, 06, 011)
      room20 = 20
      this_manager.make_res_for_room(check_in1, check_out1, room20)

      check_in5 = Date.new(2019, 05, 15)
      check_out5 = Date.new(2019, 05, 20)
      room20 = 20
      this_manager.make_res_for_room(check_in5, check_out5, room20)

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

    it "Calculates the cost of a reservation" do
      check_in = Date.new(2019, 6, 12)
      check_out = Date.new(2019, 6, 18)
      room = 1
      res = this_manager.make_res_for_room(check_in, check_out, room)
      expect(this_manager.rooms_reservations_hash[1][0].base_cost).must_equal 1200
      #   p this_manager.rooms_reservations_hash
      #   binding.pry
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
      room8 = 8
      this_manager.make_res_for_room(check_in2, check_out2, room8)
    }

    let (:res3) {
      check_in3 = Date.new(2019, 06, 11)
      check_out3 = Date.new(2019, 06, 20)
      room1 = 1
      this_manager.make_res_for_room(check_in3, check_out3, room1)
    }

    let (:res4) {
      check_in4 = Date.new(2019, 6, 8)
      check_out4 = Date.new(2019, 6, 9)
      room1 = 1
      this_manager.make_res_for_room(check_in4, check_out4, room1)
    }

    let (:res5_overlap) {
      check_in_test = Date.new(2019, 6, 8)
      check_out_test = Date.new(2019, 6, 9)
      room1 = 1
      this_manager.make_res_for_room(check_in_test, check_out_test, room1)
    }

    let (:res6_overlap_start) {
      check_in6 = Date.new(2019, 6, 10)
      check_out6 = Date.new(2019, 6, 12)
      room1 = 1
      this_manager.make_res_for_room(check_in6, check_out6, room1)
    }

    let (:res7_overlap_end) {
      check_in7 = Date.new(2019, 6, 19)
      check_out7 = Date.new(2019, 6, 22)
      room1 = 1
      this_manager.make_res_for_room(check_in7, check_out7, room1)
    }

    let (:res8_overlap_all) {
      check_in7 = Date.new(2019, 6, 10)
      check_out7 = Date.new(2019, 6, 21)
      room1 = 1
      this_manager.make_res_for_room(check_in7, check_out7, room1)
    }

    let (:res9_overlap_inside) {
      check_in7 = Date.new(2019, 6, 15)
      check_out7 = Date.new(2019, 6, 16)
      room1 = 1
      this_manager.make_res_for_room(check_in7, check_out7, room1)
    }

    let (:res10_overlap_two_res) {
      check_in7 = Date.new(2019, 6, 2)
      check_out7 = Date.new(2019, 6, 10)
      room1 = 1
      this_manager.make_res_for_room(check_in7, check_out7, room1)
    }

    let (:res11_span_month) {
      check_in = Date.new(2019, 5, 29)
      check_out = Date.new(2019, 6, 2)
      room = 9
      this_manager.make_res_for_room(check_in, check_out, room)
    }

    let (:res12_start_date_align) {
      check_in = Date.new(2019, 6, 2)
      check_out = Date.new(2019, 6, 12)
      room = 9
      this_manager.make_res_for_room(check_in, check_out, room)
    }

    let (:res13_end_date_align) {
      check_in = Date.new(2019, 6, 12)
      check_out = Date.new(2019, 6, 15)
      room = 9
      this_manager.make_res_for_room(check_in, check_out, room)
    }
    let (:res14_append_to_beginning_with_overlap) {
      check_in = Date.new(2019, 5, 12)
      check_out = Date.new(2019, 5, 29)
      room = 9
      this_manager.make_res_for_room(check_in, check_out, room)
    }

    let (:res15_no_room_21) {
      check_in = Date.new(2019, 5, 12)
      check_out = Date.new(2019, 5, 29)
      room = 21
      this_manager.make_res_for_room(check_in, check_out, room)
    }

    let (:res16_no_room_1) {
      check_in = Date.new(2019, 7, 2)
      check_out = Date.new(2019, 7, 3)
      room = 0
      this_manager.make_res_for_room(check_in, check_out, room)
    }

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
      res3
      check_in = Date.new(2019, 6, 8)
      check_out = Date.new(2019, 6, 9)
      room = 1
      this_manager.make_res_for_room(check_in, check_out, room)

      expect(this_manager.rooms_reservations_hash[1][1].ckout_date.to_s).must_equal "2019-06-09"
    end

    it "Raise an argument error if the room is unavailable for the date" do
      this_manager
      res1
      res3
      res4

      expect { res5_overlap }.must_raise ArgumentError # new res has exact dates match of existing res
      expect { res6_overlap_start }.must_raise ArgumentError # new res overlaps start of existing res
      expect { res7_overlap_end }.must_raise ArgumentError # new res overlaps end of existing res
      expect { res8_overlap_all }.must_raise ArgumentError # new res overlaps all dates of existing res
      expect { res9_overlap_inside }.must_raise ArgumentError # new res overlaps contained dates of existing res
      expect { res10_overlap_two_res }.must_raise ArgumentError # new res overlaps contained dates of existing
    end

    it "Can create a reservation at edges of months" do
      res11_span_month

      expect(this_manager.rooms_reservations_hash[9][0].ckin_date.to_s).must_equal "2019-05-29"
    end

    it "Reservation is allowed if check in or check out is same as another reservation's check in or check out date" do
      res11_span_month
      res12_start_date_align
      res13_end_date_align
      res14_append_to_beginning_with_overlap
      #   puts "==================="
      #   this_manager.rooms_reservations_hash[9].each_with_index do |res, i|
      #     puts "Index #{i}: #{res.ckin_date} - #{res.ckout_date}"
      #   end
      expect(this_manager.rooms_reservations_hash[9][0].ckin_date.to_s).must_equal "2019-05-12"
      expect(this_manager.rooms_reservations_hash[9][1].ckin_date.to_s).must_equal "2019-05-29"
      expect(this_manager.rooms_reservations_hash[9][2].ckin_date.to_s).must_equal "2019-06-02"
      expect(this_manager.rooms_reservations_hash[9][3].ckin_date.to_s).must_equal "2019-06-12"
    end

    it "Won't add a new reservation to a room that doesn't exist" do
      this_manager

      #   binding.pry

      expect {
        res15_no_room_21
      }.must_raise Exception

      expect {
        res16_no_room_1
      }.must_raise Exception
    end
  end
end
