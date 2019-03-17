require 'date'
# # require_relative 'hotel.rb'

module Booking
  class Block

    attr_reader :checkin_date, :checkout_date, :requested_rooms, :discounted_rate, :party_name, :room_block, :block_of_rooms, :all_rooms, :max_rooms, :room_numbers, :hotel, :all_reservations
    
    # attr_accessor :hotel, :rooms

    def initialize(checkin_date, checkout_date, requested_rooms, discounted_rate, hotel: nil)
    @checkin_date = checkin_date
    @checkout_date = checkout_date 
    @block_of_rooms ||= []
    @hotel ||= hotel
    @available_rooms = @hotel.check_availability(checkin_date, checkout_date)
    @all_reservations = @hotel.all_reservations
    @discounted_rate = discounted_rate


    requested_rooms.each do |room|
      if @block_of_rooms.include?(room)
        raise ArgumentError, "That room is already in a block."
      elsif !@available_rooms.include?(room)
        raise ArgumentError, "That room is unavailable"
      else
        @requested_rooms = requested_rooms
      end
    end
    
    @room_block = []
    
    @room_numbers = room_numbers
    
    
    @all_rooms = @hotel.all_rooms
    
    
    

  end

    def room_numbers
      i = 0

      requested_rooms.each do |room|
        unless @available_rooms == nil
          if !@available_rooms.include?(room)
            raise ArgumentError, "That room is unavailable."
          end
        end

        if requested_rooms.length > 5
          raise ArgumentError, "A block can have 5 rooms maximum."
        else
          @hotel.all_rooms.each do |room|
            if room == requested_rooms[i]
            reserved_room = room
            @room_block << reserved_room
            end
          end
        i += 1
      end
    end
      # @room_numbers = @room_block.map do |room|
      # room.number
      # end
      @block_of_rooms << @room_block
      return @room_block
    end

    
    def available_rooms
      if @room_numbers != nil
        @available_rooms = hotel.check_availability(checkin_date, checkout_date) - @room_numbers
     
      elsif @hotel.available_rooms == nil
        raise ArgumentError, "There are no available rooms."
      end
     return @available_rooms
    end

    def block_availability(block)
    available_rooms = []
    block.block_of_rooms.each do |room|
      available_rooms << room
      end
    return available_rooms
    end

    def reserve_room(number)
      @block_of_rooms.flatten.each do |room|
        if room == number
          reservation = @hotel.add_reservation(checkin_date, checkout_date, room: number, cost: discounted_rate)
          return reservation
        end
      end
      
    end


  end # END OF CLASS
end # END OF MODULE


