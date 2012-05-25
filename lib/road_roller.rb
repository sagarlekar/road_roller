require 'rgeo'
require 'rgeo/shapefile'
require 'road_roller_helper'
#require 'math'

class RoadRoller

	def initialize(filename)
		# absolute path to the shapefile e.g. /home/user/roads.shp
		@filename = filename
	end

	def get_filename
		@filename
  end

  def open_shapefile
    @shapefile =  RGeo::Shapefile::Reader.open(@filename)
  end

  def divide_roads_into_points(distance=1)
    open_shapefile()

  @shapefile.each do |road|

    road.geometry.each do |linestring|
      puts linestring.as_text
      divide_road_into_points(linestring, distance)
      end
    end
  end

  def divide_road_into_points(road, distance)
      road.points.each do |pt|
        puts "   " + pt.as_text
      end
  end





end

