

## I MIGHT WANT TO CREATE A BLOCK MANAGER
# I want an exception raised if I try to create a Hotel Block and at least one of the rooms is unavailable for the given date range --> Might be able to inherit this funtionality from reseervation manager
# Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot reserve that specific room for that specific date, because it is unavailable --> if I do inheritance all of these are going to be awkward??
# Given a specific date, and that a room is set aside in a hotel block for that specific date, I cannot create another hotel block that includes that specific room for that specific date, because it is unavailable
# I can check whether a given block has any rooms available
# I can reserve a specific room from a hotel block
# I can only reserve that room from a hotel block for the full duration of the block
# I can see a reservation made from a hotel block from the list of reservations for that date (see wave 1 requirements)
# Details
# A block can contain a maximum of 5 rooms
# When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
# All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations
