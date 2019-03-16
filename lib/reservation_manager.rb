require_relative "reservation"
require_relative "room"
require_relative "block"
require "awesome_print"

module Hotel
  class ReservationManager
    attr_reader :rooms, :reservations, :blocks

    def initialize
      @rooms = Hotel::Room.load_all
      @reservations = Hotel::Reservation.load_all
      @blocks = Hotel::Block.load_all
      # @reservations = reservations || Hotel::Reservation.load_all
      # connect_reservations
    end

    def reserve(room_id:, check_in_date:, check_out_date:)
      raise ArgumentError, "room_id is required" if room_id == nil
      raise ArgumentError, "check_in_date is required" if check_in_date == nil
      raise ArgumentError, "check_out_date is required" if check_out_date == nil

      self.class.validate_date(check_in_date)
      self.class.validate_date(check_out_date)
      self.class.validate_date_range(check_in_date, check_out_date)
      available_rooms = find_available_rooms(check_in_date: check_in_date, check_out_date: check_out_date)
      available_room_ids = available_rooms.map { |room| room.room_id }
      raise ArgumentError, "Room #{room_id} is not available for this date range!" if available_room_ids.include?(room_id) == false
      # raise ArgumentError, "Room #{room.room_id} is not available for this date range!" if available_rooms.include?(room) == false
      # new_reservation(room_id, check_in_date, check_out_date)
      new_reservation = Hotel::Reservation.new(
        reservation_id: @reservations.length + 1,
        room_id: room_id,
        check_in_date: check_in_date,
        check_out_date: check_out_date,
      )
      add_reservation(new_reservation)
    end

    def list_reservations(date:)
      self.class.validate_date(date)
      date = Date.parse(date)
      reservations = self.reservations.select do |reservation|
        date >= reservation.check_in_date && date < reservation.check_out_date
      end
      return reservations
    end

    def find_available_rooms(check_in_date: nil, check_out_date: nil)
      self.class.validate_date(check_in_date)
      self.class.validate_date(check_out_date)
      self.class.validate_date_range(check_in_date, check_out_date)
      check_in_date = Date.parse(check_in_date)
      check_out_date = Date.parse(check_out_date)
      na_reservations = get_na_objects(@reservations, check_in_date, check_out_date)
      na_blocks = get_na_objects(@blocks, check_in_date, check_out_date)
      na_room_ids_blocks = []
      na_blocks.each do |block|
        block.room_ids.each do |i|
          na_room_ids_blocks << i
        end
      end
      na_room_ids_reservations = na_reservations.map { |reservation| reservation.room_id }
      na_room_ids = (na_room_ids_blocks + na_room_ids_reservations).uniq
      # na_rooms = (na_blocks + na_rooms_reservations).uniq
      return @rooms.reject do |room|
               na_room_ids.include?(room.room_id)
             end
    end

    def create_block(room_ids:, check_in_date:, check_out_date:, discount_rate:)
      self.class.validate_date(check_in_date)
      self.class.validate_date(check_out_date)
      self.class.validate_date_range(check_in_date, check_out_date)
      available_rooms = find_available_rooms(check_in_date: check_in_date, check_out_date: check_out_date)
      available_room_ids = available_rooms.map { |room| room.room_id }
      room_ids.each do |room_id|
        raise ArgumentError, "Room #{room_id} is not available" if available_room_ids.include?(room_id) == false
      end
      # available_rooms.each do |room|
      #   raise ArgumentError, "Room #{room.room_id} is not available" if available_rooms.include?(room) == false
      # end
      new_block = Hotel::Block.new(
        block_id: @blocks.length + 1,
        room_ids: room_ids,
        check_in_date: check_in_date,
        check_out_date: check_out_date,
        discount_rate: discount_rate,
      )
      @blocks << new_block
    end

    def check_rooms_in_blocks(block_id)
      block = @blocks.find { |current_block| current_block.block_id == block_id }
      raise ArgumentError, "No block found" if block == nil
      return block.room_ids
    end

    def reserve_from_block(room_id: nil, block_id: nil)
      raise ArgumentError, "room_id is required" if room_id == nil
      raise ArgumentError, "block is required" if block_id == nil
      block = @blocks.find { |block| block.block_id == block_id }
      new_reservation = Hotel::Reservation.new(
        reservation_id: @reservations.length + 1,
        room_id: room_id,
        check_in_date: block.check_in_date,
        check_out_date: block.check_out_date,
      )
      add_reservation(new_reservation)
    end

    def self.validate_room_id(room_id)
      if room_id.nil? || room_id <= 0 || room_id.class != Integer || room_id > Room.num_rooms
        raise ArgumentError, "ID must be an integer and cannot be blank, less than zero or larger than #{Room.num_rooms}"
      end
    end

    # need to move into validate date range method
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

    private

    def get_na_objects(array_object, check_in_date, check_out_date)
      return array = array_object.select do |object|
               check_in_date < object.check_out_date && check_in_date >= object.check_in_date ||
               check_out_date > object.check_in_date && check_out_date < object.check_out_date ||
               check_in_date < object.check_in_date && check_out_date > object.check_out_date
             end
    end

    def add_reservation(new_reservation)
      @reservations << new_reservation
    end

    # def new_reservation(room_id, check_in_date, check_out_date)
    #   Hotel::Reservation.new(
    #     reservation_id: @reservations.length + 1,
    #     room_id: room_id,
    #     check_in_date: check_in_date,
    #     check_out_date: check_out_date,
    #   )
    # end

    # def connect_reservations
    #   @reservations.each do |reservation|
    #     room = find_room(reservation.room_id)
    # reservation.connect(room)
    # end
    # end
  end
end

# rm = Hotel::ReservationManager.new
# p rm.create_block([Hotel::Room.new(1), Hotel::Room.new(2), Hotel::Room.new(3)], "2019-03-10", "2019-03-15", 0.10)
