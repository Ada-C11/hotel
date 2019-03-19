require_relative "reservation"
require_relative "room"
require_relative "block"
require "awesome_print"

module Hotel
  class ReservationManager

    # To access the list of all of the rooms, reservations and blocks in the hotel
    attr_reader :rooms, :reservations, :blocks

    def initialize
      @rooms = Hotel::Room.load_all
      @reservations = Hotel::Reservation.load_all
      @blocks = Hotel::Block.load_all
    end

    # I can reserve an available room for a given date range
    def reserve(room_id:, check_in_date:, check_out_date:)
      self.class.validate_id(room_id)
      # I want exception raised when an invalid date range is provided
      self.class.validate_date(check_in_date)
      self.class.validate_date(check_out_date)
      self.class.validate_date_range(check_in_date, check_out_date)
      available_rooms = find_available_rooms(check_in_date: check_in_date, check_out_date: check_out_date)
      available_room_ids = available_rooms.map { |room| room.room_id }

      # I want an exception raised if I try to reserve a room that is unavailable for a given day
      raise ArgumentError, "Room #{room_id} is not available for this date range!" if available_room_ids.include?(room_id) == false
      new_reservation = Hotel::Reservation.new(
        reservation_id: @reservations.length + 1,
        room_id: room_id,
        check_in_date: check_in_date,
        check_out_date: check_out_date,
      )
      add_reservation(new_reservation)
    end

    # I can access the list of reservations for a specific date, so that I can track reservations by date
    def list_reservations(date:)
      self.class.validate_date(date)
      date = Date.parse(date)
      reservations = self.reservations.select do |reservation|
        date >= reservation.check_in_date && date < reservation.check_out_date
      end
      return reservations
    end

    # I can get the total cost for a given reservation
    def total_cost(reservation_id:)
      reservation = @reservations.find { |current_reservation| current_reservation.reservation_id == reservation_id }
      num_nights = reservation.check_out_date - reservation.check_in_date
      return num_nights * Hotel::Room.cost
    end

    # I can view a list of rooms that are not reserved for a given date range
    def find_available_rooms(check_in_date:, check_out_date:)
      self.class.validate_date(check_in_date)
      self.class.validate_date(check_out_date)
      self.class.validate_date_range(check_in_date, check_out_date)
      check_in_date = Date.parse(check_in_date)
      check_out_date = Date.parse(check_out_date)
      na_reservations = get_na_objects(@reservations, check_in_date, check_out_date)

      # Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot reserve or create a block for that specific room for that specific date
      na_blocks = get_na_objects(@blocks, check_in_date, check_out_date)
      na_room_ids_blocks = []
      na_blocks.each do |block|
        block.room_ids.each do |i|
          na_room_ids_blocks << i
        end
      end

      na_room_ids_reservations = na_reservations.map { |reservation| reservation.room_id }
      na_room_ids = (na_room_ids_blocks + na_room_ids_reservations).uniq
      return @rooms.reject do |room|
               na_room_ids.include?(room.room_id)
             end
    end

    # I can create a Hotel Block if I give a date range, collection of rooms, and a discounted room rate
    def create_block(room_ids:, check_in_date:, check_out_date:, discount_rate:)
      room_ids.each { |room_id| self.class.validate_id(room_id) }
      self.class.validate_date(check_in_date)
      self.class.validate_date(check_out_date)
      self.class.validate_date_range(check_in_date, check_out_date)
      available_rooms = find_available_rooms(check_in_date: check_in_date, check_out_date: check_out_date)
      available_room_ids = available_rooms.map { |room| room.room_id }

      # I want an exception raised if I try to create a Hotel Block and at least one of the rooms is unavailable for the given date range
      room_ids.each do |room_id|
        raise ArgumentError, "Room #{room_id} is not available" if available_room_ids.include?(room_id) == false
      end
      new_block = Hotel::Block.new(
        block_id: @blocks.length + 1,
        room_ids: room_ids,
        check_in_date: check_in_date,
        check_out_date: check_out_date,
        discount_rate: discount_rate,
      )
      @blocks << new_block
      store_blocks_in_csv
    end

    # I can check whether a given block has any rooms available
    def check_available_rooms_in_blocks(block_id:)
      self.class.validate_id(block_id)
      block = @blocks.find { |current_block| current_block.block_id == block_id }
      raise ArgumentError, "Block #{block_id} is not found" if block == nil
      return block.rooms_info.select do |room_id, status|
               status == :AVAILABLE
             end
    end

    # I can reserve a specific room from a hotel block
    def reserve_from_block(room_id:, block_id:)
      self.class.validate_id(room_id)
      self.class.validate_id(block_id)
      block = @blocks.find { |block| block.block_id == block_id }
      block.rooms_info.each do |current_room_id, status|
        block.rooms_info[current_room_id] = :UNAVAILABLE if current_room_id == room_id
      end

      new_reservation = Hotel::Reservation.new(
        reservation_id: @reservations.length + 1,
        room_id: room_id,
        check_in_date: block.check_in_date.to_s,
        check_out_date: block.check_out_date.to_s,
      )
      # I can see a reservation made from a hotel block
      add_reservation(new_reservation)
      # update block to take into consideration the changed status of the reserved room
      store_blocks_in_csv
    end

    # Optional Enhancement: Add functionality that allows for setting different rates for different rooms
    def set_room_rate(room_id:, room_rate:)
      @rooms.each do |room|
        room.cost = room_rate if room.room_id == room_id
      end
    end

    private

    def self.validate_date(date)
      raise ArgumentError, "Date cannot be nil" if date == nil
      raise ArgumentError, "Date must be a String" if date.class != String
      raise ArgumentError, "Date must be in the format yyyy-mm-dd" if date !~ /^(\d{4})\-(\d{1,2})\-(\d{1,2})$/
      groups = date.match(/^(\d{4})\-(\d{1,2})\-(\d{1,2})$/)
      raise ArgumentError, "Month cannot be larger than 12" if groups[2].to_i > 12
      raise ArgumentError, "Day cannot be larger than 31" if groups[3].to_i > 31
    end

    def self.validate_date_range(start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      raise ArgumentError, "Check_out_date must be after check_in_date" if end_date < start_date
    end

    def get_na_objects(array_object, check_in_date, check_out_date)
      return array = array_object.select do |object|
               check_in_date < object.check_out_date && check_in_date >= object.check_in_date ||
               check_out_date > object.check_in_date && check_out_date < object.check_out_date ||
               check_in_date < object.check_in_date && check_out_date > object.check_out_date
             end
    end

    def add_reservation(new_reservation)
      @reservations << new_reservation
      store_reservations_in_csv
    end

    def store_reservations_in_csv
      reservations_csv = CSV.open("support/reservations.csv", "w+", write_headers: true, headers: ["reservation_id", "room_id", "check_in_date", "check_out_date"])
      @reservations.each do |reservation|
        reservation_hash = { "reservation_id" => reservation.reservation_id,
                            "room_id" => reservation.room_id,
                            "check_in_date" => reservation.check_in_date,
                            "check_out_date" => reservation.check_out_date }
        reservations_csv << reservation_hash
      end
    end

    def store_blocks_in_csv
      blocks_csv = CSV.open("support/blocks.csv", "w+", write_headers: true, headers: ["block_id", "rooms_info", "check_in_date", "check_out_date", "discount_rate"])
      @blocks.each do |block|
        block_hash = {
          "block_id" => block.block_id,
          "rooms_info" => block.rooms_info,
          "check_in_date" => block.check_in_date,
          "check_out_date" => block.check_out_date,
          "discount_rate" => block.discount_rate,
        }
        blocks_csv << block_hash
      end
    end

    def self.validate_id(id)
      if id.nil? || id <= 0 || id.class != Integer
        raise ArgumentError, "ID must be an integer and cannot be blank or less than zero."
      end
    end
  end
end
