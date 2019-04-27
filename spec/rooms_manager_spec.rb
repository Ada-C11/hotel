# # rooms spec
require_relative 'spec_helper'

 describe 'Room class' do
   room_number = 1
   price_per_night = 200

   let(:room) { Hotel::Room.new(room_number, price_per_night) }

   describe 'initialize' do
     it 'is instance of Room' do
       room.must_be_kind_of Hotel::Room
     end

     it 'set up for specific attribuites and data types' do
       %i[room_number price_per_night].each { |prop| room.must_respond_to prop }

       room.room_number.must_be_kind_of Integer
       room.price_per_night.must_be_kind_of Integer
     end
    
   end
end
