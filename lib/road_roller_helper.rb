require 'mathn'


module RoadRollerHelper


  def RoadRollerHelper.to_radians(angle)
      angle/180 * Math::PI
  end


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

  def RoadRollerHelper.get_line_length(lat1, lon1, lat2, lon2, distance)

    length_sqr = (lat2-lat1)*(lat2-lat1) + (lon2-lon1)*(lon2-lon1)

    length = Math.sqrt(length_sqr)

  end

end
