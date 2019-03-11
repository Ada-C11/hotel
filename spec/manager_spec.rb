describe "Instatiation" do
  it "RED" do
    @manager = Hotel::Manager.new(GREEN)
    expect(@manager).must_be_kind_of Hotel::Manager
  end
end
