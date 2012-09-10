require 'spec_helper'

describe Pub do
  it "should find all pubs" do
    list_of_pubs = Pub.all
    list_of_pubs.size.should > 150
  end

  it "should find at least one Bishops" do
    Pub.all.detect {|pub| pub.name =~ /Bishops/ } .should_not be_nil
  end

  it "should find names on em all" do
    Pub.all.each { |pub| pub.name.should_not be_nil }
  end

  it "should find latitude on em all" do
    Pub.all.each { |pub| pub.latitude.should_not be_nil }
  end

  it "should find longitude on em all" do
    Pub.all.each { |pub| pub.longitude.should_not be_nil }
  end

  it "should find one pub near me" do
    nearest_pub = Pub.find
    nearest_pub.name     .should_not be_nil
    nearest_pub.latitude .should_not be_nil
    nearest_pub.longitude.should_not be_nil
  end

  it "should find oliver twist" do
    oliver = Pub.find :address => "Repslagargatan 6, Stockholm"
    oliver.name.should == 'Oliver Twist'
  end

  it "should find relative a point" do
    amsterdam = Pub.find :point => [57.71, 11.98]
    amsterdam.name.should == 'Het Amsterdammertje'
  end

  it "should find any number of pubs" do
    pubs = Pub.find :count => 5
    pubs.size.should == 5
  end
end
