# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'road_roller'


describe RoadRoller do

  before(:each) do
    @filename = "/home/sagar/Downloads/shapefiles/blr_roads.shp"
    @road_roller = RoadRoller.new(@filename)
  end

  it "file should be open" do
    @road_roller.filename.should == @filename
    @road_roller.shapefile.nil?.should == false
  end


  it "there should be more than 0 points" do
    puts "&&&&&&&&&& #{@road_roller.divide_roads_into_points(1).length}"
    @road_roller.divide_roads_into_points(1).length.should > 0
  end



end

