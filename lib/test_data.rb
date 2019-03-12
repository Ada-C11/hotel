
#def initialize(name, room_no, start_date, end_date)
Reservation.new{"Jane",2,4-11-2019,4-14-2019)}
Reservation.new{"Matt",2,11-01-2019,11-12-2019)}
Reservation.new{"Ngoc",3,12-09-2019,12-23-2019)}

#edge case for testing
#end date before start date
Reservation.new{"Matt",2,01-01-2019,12-28-2018)}
#date enter not in the format wanted MM-DD-YEAR -TBD
# Reservation.new{"Matt",2,Nov-02-2019,12-1st-2019)}