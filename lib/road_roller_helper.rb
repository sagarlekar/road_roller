# Author - Sagar Arlekar
# Email - sagar.arlekar@gmail.com

require 'mathn'
require 'csv'


# This module has methods to assist the RoadRoller class.
module RoadRollerHelper

  # Converts angle from degree to radians.
  # * +angle+ - The angle in degrees
  def RoadRollerHelper.to_radians(angle)
      angle/180 * Math::PI
  end

  # Converts angle from radians to degrees.
  # * +angle+ - The angle in radians
  def RoadRollerHelper.to_degrees(angle)
      angle/(Math::PI / 180)
  end


    def RoadRollerHelper.calculate_bearing(lat1, lon1, lat2, lon2)
        radlat1 = to_radians(lat1);
        radlat2 = to_radians(lat2);

        dlon = to_radians(lon2 - lon1);

        y = Math.sin(dlon) * Math.cos(radlat2);
        x = Math.cos(radlat1) * Math.sin(radlat2) - Math.sin(radlat1) * Math.cos(radlat2) * Math.cos(dlon);

        bearing = to_degrees(Math.atan2(y, x));
        return bearing % 360;
   end


  # Converts degrees to meters. This method is an approximation.
  # * +distance+ - The distance in degrees.
  # * +lat+ - The lattitue of one of the end points. For small distances which end points is selected does not matter much.
   def RoadRollerHelper.degrees_to_meters(distance, lat)
    meters = distance * 3.14 * 6378100 / 180 * Math.cos(to_radians(lat))
   end

  # Converts meters to degrees. This method is an approximation.
  # * +distance+ - The distance in meters.
  # * +lat+ - The lattitue of one of the end points. For small distances which end points is selected does not matter much.
 def RoadRollerHelper.meters_to_degrees(distance, lat)
    degress = distance / 3.14 / 6378100 * 180 / Math.cos(to_radians(lat))

  end

# Gets line lenth in degrees. The line is defined by end points (lat1, lon1) and (lat2, lon2).
  def RoadRollerHelper.get_line_length(lat1, lon1, lat2, lon2)

    length_sqr = (lat2-lat1)*(lat2-lat1) + (lon2-lon1)*(lon2-lon1)

    length = Math.sqrt(length_sqr)

   end

# Writes points in points_hash to a file as CSVs.
# * +filename+ - The name of the original shapefile.
# * +points_hash+ - A hash in the form ["id_field" => [list of points]], i.e. id of the road and the points representing it. File output will be in the form

  def RoadRollerHelper.export_csv(filename, points_hash)

    CSV.open(filename, "wb") do |csv|

    points_hash.each do |id, points|
      points.each do |point|
        csv << [id, point[0], point[1]]
      end
    end

    end
   end
 end
