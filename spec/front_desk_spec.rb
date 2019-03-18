require_relative "spec_helper"

module Hotel
  describe "class FrontDesk" do
    def build_front_desk
      return Hotel::FrontDesk.new
    end

    describe "all arrays" do
      before do
        @concierge = build_front_desk
      end

      it "will say that all_rooms is an array" do
        expect(@concierge.all_rooms_array).must_be_kind_of Array
      end

      it "will say all_rooms_array has a length of 20" do
        expect(@concierge.all_rooms_array.length).must_equal 20
      end

      it "will say element at all_rooms index 0 is 1" do
        expect(@concierge.all_rooms_array[0]).must_equal 1
      end
      it "will say element at all_rooms index 19 is 20" do
        expect(@concierge.all_rooms_array[19]).must_equal 20
      end

      it "will say reservations_record is an array" do
        expect(@concierge.reservations_record).must_be_kind_of Array
      end

      it "will say block_reservations_only is an array " do
        expect(@concierge.block_reservations_only).must_be_kind_of Array
      end

      it "will say reserved_rooms_in_blocks_is an array" do
        expect(@concierge.reserved_rooms_in_blocks).must_be_kind_of Array
      end

      it "will say reserved_rooms_in_blocks array length is 0" do
        expect(@concierge.reserved_rooms_in_blocks.length).must_equal 0
      end

      it "will say block_reservations_only array length is 0" do
        expect(@concierge.block_reservations_only.length).must_equal 0
      end

      it "will say reservations_record array length is 0" do
        expect(@concierge.reservations_record.length).must_equal 0
      end
    end

    describe "make_reservation for block and add_reservation methods" do
      before do
        @concierge = build_front_desk
      end
      it "will describe various attributes of the reservation" do
        reservation_1 = @concierge.make_reservation(
          1201,
          5,
          1,
          Date.new(2019, 3, 20),
          Date.new(2019, 3, 24),
        )
        @concierge.add_reservation(reservation_1)
        expect(reservation_1.booking_ref).must_equal 1201
        expect(reservation_1.number_of_rooms).must_equal 5
        expect(reservation_1.first_room_number).must_equal 1
        expect(@concierge.reservations_record.length).must_equal 1
        expect(@concierge.reservations_record[0].total_cost).must_equal 3200.00
        expect(@concierge.reservations_record[0].room_blocks[4]).must_equal 5
        expect(@concierge.reservations_record[0].room_blocks.length).must_equal 5
        expect(reservation_1.check_in).must_equal Date.new(2019, 3, 20)
        expect(reservation_1.check_out).must_equal Date.new(2019, 3, 24)
      end
    end

    describe "get reservation by a specific date" do
      before do
        @concierge = build_front_desk
      end

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

    describe "room_availability method" do
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

    describe "raise an ArgumentError if check_in date is before current date" do
      before do
        @concierge = build_front_desk
      end
      it "will raise an error if check_in date is before current date" do
        expect {
          @concierge.make_reservation(
            30011,
            1,
            19,
            Date.new(2019, 3, 10),
            Date.new(2019, 3, 25)
          )
        }.must_raise ArgumentError
      end
    end

    describe "raise an ArgumentError if check_out date is before check_in date" do
      before do
        @concierge = build_front_desk
      end
      it "will raise an error if check_out date is before check_in date" do
        expect {
          @concierge.make_reservation(
            30111,
            1,
            20,
            Date.new(2019, 3, 28),
            Date.new(2019, 3, 25)
          )
        }.must_raise ArgumentError
      end
    end

    describe "raise an ArgumentError if check_out date is before current date" do
      before do
        @concierge = build_front_desk
      end
      it "will raise an ArgumentError if check_out date is before current date" do
        expect {
          @concierge.make_reservation(
            30111,
            1,
            20,
            Date.new(2019, 9, 8),
            Date.new(2019, 2, 25)
          )
        }.must_raise ArgumentError
      end
    end

    describe "block cannot have more than 5 rooms" do
      before do
        @concierge = build_front_desk
      end
      it "will throw an error if there is an attempt to create a block with more than 5 rooms" do
        expect {
          @concierge.make_reservation(
            450111,
            7,
            10,
            Date.new(2019, 8, 8),
            Date.new(2019, 8, 12)
          )
        }.must_raise ArgumentError
      end
    end

    describe "Number of rooms in Hotel cannot exceed 20" do
      before do
        @concierge = build_front_desk
      end
      it "will throw an error if there is an attempt to create a reservation for a room beyond 20" do
        expect {
          @concierge.make_reservation(
            5501,
            5,
            17,
            Date.new(2019, 10, 8),
            Date.new(2019, 10, 12)
          )
        }.must_raise ArgumentError
      end
    end

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
      end

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
      end
    end

    describe "add_block_reservations method" do
      before do
        @concierge = build_front_desk
      end

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
      end
    end

    describe "room availbilty in block" do
      before do
        @concierge = build_front_desk
      end

      it "will say all the rooms that are in a block" do
        reservation_5 = @concierge.make_reservation(
          3002,
          2,
          17,
          Date.new(2019, 7, 5),
          Date.new(2019, 7, 7),
        )
        @concierge.add_reservation(reservation_5)
        @concierge.add_block_reservations

        all_block_rooms = @concierge.all_rooms_in_blocks(Date.new(2019, 7, 6))
        expect(all_block_rooms).must_be_kind_of Array
        expect(all_block_rooms.length).must_equal 2
        expect(all_block_rooms[0]).must_equal 17
        expect(all_block_rooms[1]).must_equal 18
      end
    end

    describe "I cannot create another hotel block for unavailable room for that specific date" do
      before do
        @concierge = build_front_desk
      end
      it "will raise an error if I try to create another hotel block for unavailable room for that specific date" do
        reservation_32 = @concierge.make_reservation(
          3065,
          5,
          11,
          Date.new(2019, 7, 5),
          Date.new(2019, 7, 8),
        )
        @concierge.add_reservation(reservation_32)
        @concierge.add_block_reservations

        expect {
          @concierge.make_reservation(
            3069,
            2,
            14,
            Date.new(2019, 7, 5),
            Date.new(2019, 7, 8),
          )
        }.must_raise ArgumentError

        expect {
          @concierge.make_reservation(
            3069,
            2,
            12,
            Date.new(2019, 7, 5),
            Date.new(2019, 7, 8),
          )
        }.must_raise ArgumentError

        expect {
          @concierge.make_reservation(
            3069,
            4,
            8,
            Date.new(2019, 7, 5),
            Date.new(2019, 7, 8),
          )
        }.must_raise ArgumentError
      end
    end

    describe "make_reservation_in_block method" do
      before do
        @concierge = build_front_desk
      end

      it "will describe reserved rooms in block" do
        reservation_6 = @concierge.make_reservation(
          3002,
          2,
          17,
          Date.new(2019, 7, 5),
          Date.new(2019, 7, 7),
        )
        @concierge.add_reservation(reservation_6)
        @concierge.add_block_reservations

        new_reservation = @concierge.make_reservation_in_block(
          3003,
          17,
          Date.new(2019, 7, 5),
          Date.new(2019, 7, 7),
        )

        reserved_room = @concierge.add_block_room_reservation(new_reservation)

        avail_rooms = @concierge.block_room_availability(Date.new(2019, 7, 5))

        expect(@concierge.reserved_rooms_in_blocks).must_be_kind_of Array
        expect(@concierge.reserved_rooms_in_blocks.length).must_equal 1
        expect(new_reservation.block_room_number).must_equal 17
        expect(avail_rooms).must_be_kind_of Array
        expect(avail_rooms.length).must_equal 1
        expect {
          @concierge.make_reservation_in_block(
            30090,
            18,
            Date.new(2019, 7, 5),
            Date.new(2019, 7, 6),
          )
        }.must_raise ArgumentError
      end
    end

    describe "block reservations by date" do
      before do
        @concierge = build_front_desk
      end

      it "will get block reservations by date" do
        reservation_7 = @concierge.make_reservation(
          3003,
          3,
          10,
          Date.new(2019, 7, 7),
          Date.new(2019, 7, 10),
        )
        @concierge.add_reservation(reservation_7)
        @concierge.add_block_reservations

        blocks_by_date = @concierge.block_reservations_by_date(Date.new(2019, 7, 7))
        expect(blocks_by_date).must_be_kind_of Array
        expect(blocks_by_date.length).must_equal 1
        expect(blocks_by_date[0].number_of_rooms).must_equal 3
        expect(blocks_by_date[0].first_room_number).must_equal 10
        expect(blocks_by_date[0].booking_ref).must_equal 3003
      end
    end
  end
end
