# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'road_roller_helper'

describe RoadRollerHelper do

  before(:each) do

  end

  it "length of line should be > 0" do
    #puts "Length = " +  RoadRollerHelper::get_line_length(1,0,4,3,1).to_s
    RoadRollerHelper::get_line_length(1,0,4,3).should > 0
  end

  it "converts degrees distance to meter" do
    puts "#{RoadRollerHelper::degrees_to_meters(1,0)}"
    RoadRollerHelper::degrees_to_meters(1,0).should > 0
  end

  it "converts meter distance to degrees" do
    puts "#{RoadRollerHelper::meters_to_degrees(112000,0)}"
    RoadRollerHelper::meters_to_degrees(112000,0).should > 0
  end

  it "writes csv file" do
    filename = "/home/sagar/Downloads/shapefiles/blr_roads.shp"
    points = [[1,2],[4,2],[3,9]]
    dir = File.dirname(filename)
    RoadRollerHelper::export_csv(dir+"/shapefile.csv", points)
  end
end

