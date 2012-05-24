require 'rgeo'
require 'rgeo/shapefile'

class RoadRoller

	def initialize(filename)
		# absolute path to the shapefile e.g. /home/user/roads.shp
		@filename = filename
	end

	def get_filename
		@filename
  end

  def divide_roads_into_point(distance=1)
    RGeo::Shapefile::Reader.open(@filename) do |shapefile|

  shapefile.each do |road|

    road.geometry.each do |linestring|
      puts linestring.as_text
      divide_road_into_point(linestring, distance)
      end
    end
    end
  end

  def divide_road_into_point(road, distance)

      road.points.each do |pt|
        puts "   " + pt.as_text
      end

  end

end
