require 'date'
require 'pry'
require_relative 'rooms_manager'
require_relative 'reservations_child'
require_relative 'booking_manager'

module Hotel
  class ReservationsManager
    # should handle the business logic for bookings
    attr_reader :rooms, :reservations, :reservation_id

    def initialize
      @rooms = load_rooms
      @reservations = {}
      @reservation_id = (1..300).to_a 
    end

    def load_rooms
     rooms = {}
     room_number = nil 
     price_per_night = nil
     (1..20).each do |id|
      rooms[number] = Hotel::Room.new(room_number, price_per_night)
    end
     return rooms 
    end

    def list_rooms
     return @rooms.values        
    end 

    def make_reservation(room_id, start_date, end_date)
     if !rooms_keys.include?(room_id)
        raise ArgumentError.new("Room number doesn't exist")
    end 

     reservations_data = {reservation_id: @reservation_id.slice!,
         room: room, 
         start_date: start_date, 
         end_date: end_date
        }

     new_reservation = Hotel::Reservations.new(reservations_data)
     @reservations[reservation_id] = new_reservation 
     return new_reservation
    end 

    def find_reservation(date)
        date = date
        reservation_found = [] 
        @reservations.each do |id, reservation|
            if reservation.start_date <= date && reservation.end_date > date
               reservation_found = reservation  
            end 
        end
    return reservation_found.values
    end
    
    def reservation_total_cost(reservation_id)
      total_to_pay = @reservations[reservation_id].reservation_cost
    return total_to_pay
    end 

    # def list_of_reservations(start_date, end_date)
    #     reserved_rooms = []
    
  end
end
