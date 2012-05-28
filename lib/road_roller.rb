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

  def divide_roads_into_points(distance)


   road_points = []

   @shapefile.each do |linestrings|

    linestrings.geometry.each do |linestring|

      linestring_points = divide_linestring_into_points(linestring, distance)

      #puts "linestring_points length = #{linestring_points.length}"

      road_points = road_points + linestring_points
      end
    end

    #puts "road_points length = #{road_points.length}"
    return road_points
  end

  def divide_linestring_into_points(road, distance)
      points = road.points


      i = 0
      linestring_points = []
      while( i < points.length - 1)
        start_point = points[i]
        end_point = points[i+1]
        distance_degrees = RoadRollerHelper.meters_to_degrees(distance, start_point.y)
        #puts "%%%% #{RoadRollerHelper.get_line_length(start_point.y, start_point.x, end_point.y, end_point.x)} + #{distance_degrees}"
        linestring_points = linestring_points + divide_line_into_points(start_point.y, start_point.x, end_point.y, end_point.x, distance_degrees)
        i=i+1
      end

      puts "linestring_points = #{linestring_points.length}"
      return linestring_points
  end


  def divide_line_into_points(lat1, lon1, lat2, lon2, distance)
    # puts "in line #{lat1}, #{lon1}, #{lat2}, #{lon2}, #{distance}"
    points = []

    num_points = (RoadRollerHelper.get_line_length(lat1, lon1, lat2, lon2)/distance).to_i

    i = 1
      #puts "#{RoadRollerHelper.get_line_length(lat1, lon1, lat2, lon2)} #{distance}"
    while (i <= num_points)
      #puts "#{i} #{num_points}"
      lat, lon = get_new_point(lat1, lon1, lat2, lon2, distance*i)
      #puts "lat, lon => #{lat} #{lon}"
      points.push([lat, lon])
      i=i+1
    end
    puts "num_points = #{num_points} #{points.length}"
    return points
  end


  def get_new_point(lat1, lon1, lat2, lon2, distance)

    length = RoadRollerHelper.get_line_length(lat1, lon1, lat2, lon2)
    fraction_length = distance/length

    lat_new = lat1 + fraction_length * (lat2-lat1)
    lon_new = lon1 + fraction_length * (lon2-lon1)

    return lat_new, lon_new
  end



end

