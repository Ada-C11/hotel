require_relative "spec_helper"

module Hotel
  describe "class FrontDesk" do
    def build_front_desk
      return Hotel::FrontDesk.new
    end

    describe "all arrays" do
      before do
        @concierge = build_front_desk
      end # before

      it "will say that all_rooms, reservations_record, block_reservations_only, and reserved_rooms_in_blocks are arrays and all_rooms has a length of 20" do
        expect(@concierge.all_rooms_array).must_be_kind_of Array
        expect(@concierge.all_rooms_array.length).must_equal 20
        expect(@concierge.all_rooms_array[0]).must_equal 1
        expect(@concierge.all_rooms_array[19]).must_equal 20
        expect(@concierge.reservations_record).must_be_kind_of Array
        expect(@concierge.block_reservations_only).must_be_kind_of Array
        expect(@concierge.reserved_rooms_in_blocks).must_be_kind_of Array
        expect(@concierge.reservations_record.length).must_equal 0
        expect(@concierge.block_reservations_only.length).must_equal 0
        expect(@concierge.reserved_rooms_in_blocks.length).must_equal 0
      end # it
    end # describe

    describe "make_reservation and add_reservation methods" do
      before do
        @concierge = build_front_desk
      end # before

      it "adds reservation to reservations_record array" do
        reservation_1 = @concierge.make_reservation(
          1201,
          5,
          1,
          Date.new(2019, 3, 20),
          Date.new(2019, 3, 24),
        )

        @concierge.add_reservation(reservation_1)
        # Number of rooms
        expect(reservation_1.number_of_rooms).must_equal 5
        # First room number
        expect(reservation_1.first_room_number).must_equal 1
        # reservations_record array length
        expect(@concierge.reservations_record.length).must_equal 1
        # total cost of reservation_1
        expect(@concierge.reservations_record[0].total_cost).must_equal 3200.00
        # room_blocks array's element at index 4
        expect(@concierge.reservations_record[0].room_blocks[4]).must_equal 5
        # room_blocks array's length
        expect(@concierge.reservations_record[0].room_blocks.length).must_equal 5
        # reservation_1 check_in date
        expect(reservation_1.check_in).must_equal Date.new(2019, 3, 20)
        # reservation_1 check_out date
        expect(reservation_1.check_out).must_equal Date.new(2019, 3, 24)
      end # it
    end # describe

    describe "get reservation by a specific date" do
      before do
        @concierge = build_front_desk
      end # before

      it "will get a reservation by a date" do
        reservation_2 = @concierge.make_reservation(
          1202,
          2,
          9,
          Date.new(2019, 4, 8),
          Date.new(2019, 4, 10),
        )

        @concierge.add_reservation(reservation_2)

        by_date = @concierge.get_reservations_by_date(Date.new(2019, 4, 8))

        expect(by_date).must_be_kind_of Array
        expect(by_date.length).must_equal 1
        expect(reservation_2.check_in).must_be :<, Date.new(2019, 4, 10)
        expect(reservation_2.check_in).must_be :>, Date.new(2019, 4, 7)
      end # it
    end # describe

    describe "room_availablity method" do
      before do
        @concierge = build_front_desk
      end # before

      it "will return array of available rooms" do
        reservation_3 = @concierge.make_reservation(
          1001,
          3,
          15,
          Date.new(2019, 4, 8),
          Date.new(2019, 4, 21),
        )
        @concierge.add_reservation(reservation_3)

        all_available_rooms = @concierge.room_availability(
          Date.new(2019, 4, 8)
        )

        expect(all_available_rooms).must_be_kind_of Array
        expect(all_available_rooms.length).must_equal 17
      end # it
    end # describe

    describe "make reservation for a given date range" do
      before do
        @concierge = build_front_desk

        @concierge.add_reservation(@concierge.make_reservation(
          3000,
          3,
          17,
          Date.new(2019, 7, 1),
          Date.new(2019, 7, 5)
        ))
      end # before

      it "will raise an error if a reserved room's dates overlap" do
        expect {
          @concierge.make_reservation(
            3001,
            1,
            19,
            Date.new(2019, 7, 1),
            Date.new(2019, 7, 5)
          )
        }.must_raise ArgumentError
      end # it
    end # describe

    # BLOCK TESTS
    describe "add_block_reservations method" do
      before do
        @concierge = build_front_desk
      end # before

      it "will say that block_reservations_only array has blocks with more than 1 rooms" do
        reservation_4 = @concierge.make_reservation(
          3001,
          3,
          15,
          Date.new(2019, 7, 1),
          Date.new(2019, 7, 5),
        )
        @concierge.add_reservation(reservation_4)
        @concierge.add_block_reservations

        expect(@concierge.block_reservations_only.length).must_equal 1
      end # it
    end # describe
  end # describe
end # module
