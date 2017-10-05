# Author - Sagar Arlekar
# Email - sagar.arlekar@gmail.com

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'road_roller_helper'

describe RoadRollerHelper do

  before(:each) do

  end

  it "length of line should be > 0" do
    RoadRollerHelper::get_line_length(1,0,4,3).should > 4
    RoadRollerHelper::get_line_length(1,0,4,3).should > 4
  end

  it "converts degrees distance to meter" do
    RoadRollerHelper::degrees_to_meters(1,0).should > 0
  end

  it "converts meter distance to degrees" do
    RoadRollerHelper::meters_to_degrees(112000,0).should > 0
  end

  it "check whether csv file has all points written or not" do
    filename = "test_op.csv"

    points = [[1,2],[4,2],[3,9]]
    points_hash = Hash.new
    points_hash["1"] =  [[1,2],[4,2],[3,9]]
    points_hash["2"] =  [[1,2],[5,2],[3,9]]
    points_hash["3"] =  [[1,2],[4,2]]

    RoadRollerHelper::export_csv(filename, points_hash)

    line_count = 0

    File.open(filename, "r") do |infile|
      while (line = infile.gets)
         line_count = line_count + 1
      end
    end
    line_count.should == 8
    File.delete(filename)
  end
end

