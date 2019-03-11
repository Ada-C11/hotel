require 'spec_helper.rb'

describe "initialize" do
  it "returns an instance of time_interval object" do
    check_in = "2019-03-24"
    check_out = "2019-03-26"
    expect(Time_Interval.new(check_in, check_out)).must_be_instance_of Time_Interval
  end

  it "raises an argument error for wrong date format" do
    check_in = "2019/03/24"
    check_out = "2019/03/26"
    expect {
      Time_Interval.new(check_in, check_out)
    }.must_raise ArgumentError
  end
end
