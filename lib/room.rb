module Room
  NUM_OF_ROOMS = 20
  COST_PER_NIGHT = 200

  def self.make_rooms
    rooms_res_hash = {}
    (1..NUM_OF_ROOMS).each { |i| rooms_res_hash[i] = [] }
    return rooms_res_hash
  end
  # self.make_rooms builds this structure:
  # {
  #     1:[],
  #     2:[],
  #     3:[],
  #     4:[],
  #      ...,
  #     20:[]
  # }

  # def self.cost_each_night
  #   return COST_PER_NIGHT
  # end
end
