class Scheduler
  attr_reader :schedule
  
  def initialize
    @schedule = Array.new
  end

  def add_to_schedule(time_interval, id)
    @schedule.each do |h|
      @schedule << {time_interval => [id]}
    end
  end
end