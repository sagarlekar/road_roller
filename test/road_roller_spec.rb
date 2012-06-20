# Author - Sagar Arlekar
# Email - sagar.arlekar@gmail.com

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'road_roller'

describe RoadRoller do

  before(:each) do
    @filename = "/home/sagar/Downloads/shapefiles/blr_roads.shp"
    @road_roller = RoadRoller.new(@filename, 'id')
  end

  it "file should be open" do
    @road_roller.filename.should == @filename
    @road_roller.shapefile.nil?.should == false
  end

  it "there should be more than 0 points" do
    @road_roller.road_points == 53152
  end

  it "should write the output to a csv file" do
    @road_roller.divide_roads_into_points(1)
    @road_roller.export_as_csv()

    line_count = 0

    dir = File.dirname(@filename)
    filename = File.basename(@filename, ".shp")
    filename = dir + "/" + filename + ".csv"

    File.open(filename, "r") do |infile|
      while (line = infile.gets)
        line_count = line_count + 1
      end
    end
    
    print "line_count #{line_count}"
    
    line_count.should == 53152
  end

end

