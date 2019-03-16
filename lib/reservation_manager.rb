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

    def reserve(room_id, check_in_date, check_out_date)
      self.class.validate_room_id(room_id)
      self.class.validate_date(check_in_date)
      self.class.validate_date(check_out_date)
      self.class.validate_date_range(check_in_date, check_out_date)
      available_room_ids = find_available_rooms(check_in_date, check_out_date).map { |room| room.room_id }
      raise ArgumentError, "Room #{room_id} is not available for this date range!" if available_room_ids.include?(room_id) == false
      new_reservation = Hotel::Reservation.new(
        reservation_id: @reservations.length + 1,
        room_id: room_id,
        check_in_date: check_in_date,
        check_out_date: check_out_date,
      )
      @reservations << new_reservation
    end

    def list_reservations(date)
      self.class.validate_date(date)
      date = Date.parse(date)
      reservations = self.reservations.select do |reservation|
        date >= reservation.check_in_date && date < reservation.check_out_date
      end
      return reservations
    end

    def find_available_rooms(check_in_date, check_out_date)
      self.class.validate_date(check_in_date)
      self.class.validate_date(check_out_date)
      self.class.validate_date_range(check_in_date, check_out_date)
      check_in_date = Date.parse(check_in_date)
      check_out_date = Date.parse(check_out_date)
      na_reservations = @reservations.select do |reservation|
        check_in_date < reservation.check_out_date && check_in_date >= reservation.check_in_date ||
        check_out_date > reservation.check_in_date && check_out_date < reservation.check_out_date ||
        check_in_date < reservation.check_in_date && check_out_date > reservation.check_out_date
      end
      na_blocks = @blocks.select do |block|
        check_in_date < block.check_out_date && check_in_date >= block.check_in_date ||
        check_out_date > block.check_in_date && check_out_date < block.check_out_date ||
        check_in_date < block.check_in_date && check_out_date > block.check_out_date
      end
      na_room_ids_blocks = []
      na_blocks.each do |block|
        block.each do |i|
          na_room_ids_blocks << i
        end
      end
      na_room_ids_reservations = na_reservations.map { |reservation| reservation.room_id }
      na_room_ids = (na_room_ids_blocks + na_room_ids_reservations).uniq
      return @rooms.reject do |room|
               na_room_ids.include?(room.room_id)
             end
    end

    def create_block(room_ids, check_in_date, check_out_date, discount_rate)
      self.class.validate_date(check_in_date)
      self.class.validate_date(check_out_date)
      self.class.validate_date_range(check_in_date, check_out_date)
      # check_in_date = Date.parse(check_in_date)
      # check_out_date = Date.parse(check_out_date)
      available_rooms = find_available_rooms(check_in_date, check_out_date)
      available_room_ids = available_rooms.map { |room| room.room_id }
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

      # room_ids.each do |room_id|

      # end
      # room_ids[:1st] = nil
      # room_ids[:2nd] = nil
      # room_ids[:3rd] = nil
      # room_ids[:4th] = nil
      # room_ids[:5th] = nil

    end

    # def get_na(object)

    # end

    def self.validate_room_id(room_id)
      if room_id.nil? || room_id <= 0 || room_id.class != Integer || room_id > Room.num_rooms
        raise ArgumentError, "ID must be an integer and cannot be blank, less than zero or larger than #{Room.num_rooms}"
      end
    end

    # def find_room(room_id)
    #   self.class.validate_room_id(room_id)
    #   return @rooms.find { |room| room.room_id == room_id }
    # end

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

    # private

    # def connect_reservations
    #   @reservations.each do |reservation|
    #     room = find_room(reservation.room_id)
    # reservation.connect(room)
    # end
    # end
  end
end

rm = Hotel::ReservationManager.new
p rm.create_block([1, 2, 3], "2019-03-10", "2019-03-15", 0.10)
