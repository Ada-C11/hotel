require_relative "spec_helper"

describe "BlockManager" do
  let (:block_new) do
    start_date = Time.parse("2019-02-27 14:08:45 -0700")
    end_date = Time.parse("2019-02-28 14:08:45 -0700")
    rooms = [1, 4, 6, 16, 19]
    rate_discount = 10
    block = Hotel::BlockManager.create_block(start_date, end_date, rooms, rate_discount)
  end
  it "creates a block" do
    expect(block_new).must_be_instance_of Hotel::Block
  end
end

# As a user of the hotel system,
# I can create a Hotel Block if I give a date range, collection of rooms, and a discounted room rate OK
#       Create method create_block (start_date, end_date, rooms, rate_discount)
#       check there are no more than 5 rooms in the block to create
#       create an ID from blocks array

## I MIGHT WANT TO CREATE A BLOCK MANAGER
# I want an exception raised if I try to create a Hotel
# Block and at least one of the rooms is unavailable for
# the given date range --> Might be able to inherit this funtionality
# from reseervation manager
#       Check reservations when creating a block, if any of the rooms
#       in the block I'm creating is reserved raise ArgumentError

# Given a specific date, and that a room is set aside in a
# hotel block for that specific date, I cannot reserve that
# specific room for that specific date, because it is unavailable
# --> if I do inheritance all of these are going to be awkward... ??
#      Check blocks when creating a new reservation, if the room is
#      in one of the blocks don't allow reservation (raise ArgumentError?)

# Given a specific date, and that a room is set aside in a hotel
# block for that specific date, I cannot create another hotel
# block that includes that specific room for that specific date,
# because it is unavailable
#       Check blocks when creating a new block, if any of the rooms
#       in the block I'm creating is in another block (raise ArgumentError?)

# I can check whether a given block has any rooms available
#       Check a specific block by (id?) return a list of available rooms

# I can reserve a specific room from a hotel block
#       create a new reservation with one of the rooms in the list returned in last step

# I can only reserve that room from a hotel block for
# the full duration of the block
#       create a new reservation with the same start and end dates of the block

# I can see a reservation made from a hotel block from
# the list of reservations for that date (see wave 1 requirements)
#       when reserving from a block make sure that the reservation is stored within the
#       reservations and it's displayed when checking reseervations for a date range
#       in reservations manager

# Details
# A block can contain a maximum of 5 rooms
# When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
# All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations
