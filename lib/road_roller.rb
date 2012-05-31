# Author - Sagar Arlekar
# Email - sagar.arlekar@gmail.com

require 'rgeo'
require 'rgeo/shapefile'
require 'road_roller_helper'

# * This class has methods to divide roads(RGeo::Feature::LineString) into points (RGeo::Feature::Point)
class RoadRoller

  attr_accessor :shapefile, :filename, :id_field

#
# * +filename+ - The path to the shape file. E.g. /home/user/bangalore_roads.shp. The name is stored in @filename
# * +id_field+ - The field name for the unique identifie for each record. Usually id or gid field. The name is stored in @id_field
#
	def initialize(filename, id_field)
		# absolute path to the shapefile e.g. /home/user/roads.shp
		@filename = filename
    @id_field = id_field
    open_shapefile()
	end

# Will open the shapefile identified by the name in @filename. The returned shapefile(RGeo::Shapefile) is stored in @shapefile.
  def open_shapefile
    @shapefile =  RGeo::Shapefile::Reader.open(@filename)
  end

# Will fetch each road (RGeo::Feature::LineString) in the shapefile and divide it into consecutive points(Point) at a distance - distance. This function inturn calls divide_linestring_into_points()
# to divide each road into points.
# * +distance+ - Distance in meters.
  def divide_roads_into_points(distance)

   road_points = Hash.new()

   @shapefile.each do |linestrings|

  if linestrings.attributes.keys().include?(@id_field) == false
    raise "Attribute #{@id_field} is not present in the file. Kindly pass the name of the unique field in RoadRoller.new(filename, id_field)."
  end

    linestrings.geometry.each do |linestring|

      linestring_points = divide_linestring_into_points(linestring, distance)

      road_points[linestrings.attributes[@id_field]] = linestring_points
      end
    end

    puts "road_points length = #{road_points.length}"
    return road_points
  end

# Will divide road (RGeo::Feature::LineString) into consecutive points(RGeo::Feature::Point) at a distance - distance. This function inturn calls divide_linestring_into_points()
# to divide each road into points. This method inturn calls divide_line_into_points()
# * +road+ - the Linestring representing the road. A road is a RGeo::Shapefile::Reader::Record object.
# * +distance+ - Distance in meters.
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

# Will divide a line represented by (lat1, lon1) (lat2, lon2)
# * +distance+ - Distance in degree decimal. E.g. 73.143672.
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

# Given a line  (lat1, lon1) (lat2, lon2) it will return a Point (lat, lon) at an distace 'distance'.
# * +distance+ - Distance in degree decimal. E.g. 73.143672.
  def get_new_point(lat1, lon1, lat2, lon2, distance)

    length = RoadRollerHelper.get_line_length(lat1, lon1, lat2, lon2)
    fraction_length = distance/length

    lat_new = lat1 + fraction_length * (lat2-lat1)
    lon_new = lon1 + fraction_length * (lon2-lon1)

    return lat_new, lon_new
  end



end

