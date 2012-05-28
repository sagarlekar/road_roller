require 'rgeo'
require 'rgeo/shapefile'
require 'road_roller_helper'
#require 'math'

class RoadRoller

  attr_accessor :shapefile, :filename

	def initialize(filename)
		# absolute path to the shapefile e.g. /home/user/roads.shp
		@filename = filename
    open_shapefile()
	end

  def open_shapefile
    @shapefile =  RGeo::Shapefile::Reader.open(@filename)
  end

  def divide_roads_into_points(distance=1)
    road_points = []

   @shapefile.each do |linestrings|

    linestrings.geometry.each do |linestring|

      linestring_points = divide_linestring_into_points(linestring, distance)

      #puts linestring_points.to_s

      road_points.push(linestring_points)
      end
    end

    return road_points
  end

  def divide_linestring_into_points(road, distance)
      points = road.points

      i = 0
      linestring_points = []
      while( i < points.length - 1)
        start_point = points[i]
        end_point = points[i+1]
        linestring_points = divide_line_into_points(start_point.y, start_point.x, end_point.y, end_point.x, 1)
        #puts "linestring_points = #{linestring_points}"
        i=i+1
      end

      return linestring_points
  end


  def divide_line_into_points(lat1, lon1, lat2, lon2, distance)
    # puts "in line #{lat1}, #{lon1}, #{lat2}, #{lon2}, #{distance}"
    points = []

    num_points = (RoadRollerHelper.get_line_length(lat1, lon1, lat2, lon2, distance)/distance).to_i

    i = 1
      puts "#{RoadRollerHelper.get_line_length(lat1, lon1, lat2, lon2, distance)} #{distance}"
    while (i <= num_points)
      puts "#{i} #{num_points}"
      lat, lon = get_new_point(lat1, lon1, lat2, lon2, distance*i)
      #puts "lat, lon => {#lat} {#lon}"
      points.push([lat, lon])
      i=i+1
    end

    return points
  end


  def get_new_point(lat1, lon1, lat2, lon2, distance)

    length = RoadRollerHelper.get_line_length(lat1, lon1, lat2, lon2,distance)
    fraction_length = distance/length

    lat_new = lat1 + fraction_length * (lat2-lat1)
    lon_new = lon1 + fraction_length * (lon2-lon1)

    return lat_new, lon_new
  end



end

