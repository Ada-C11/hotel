
#   class Abstract
#     attr_accessor :rooms, :cost

#     def initialize(cost)
#       @rooms = [1..20]
#       @cost = 200
#       @duration = duration

#       self.class.get_rate(duration)
#     end

#     def self.get_rate(duration)
#       duration * @cost
#       raise NotImplementedError, "Implement me in a child class!"
#     end
#   end
