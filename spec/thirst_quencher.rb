
describe Pub do
  it "should find all pubs" do
    list_of_pubs = Pub.all
    list_of_pubs.size.should > 150
  end
end
