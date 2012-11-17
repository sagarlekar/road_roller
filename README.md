Road Roller
===

Road Roller is a ruby gem to pre-process spatial data for Roads Networks. This makes the data suitable for use in Agent Based Simulations, especially in transportation and motion simulations.
Spatial data for roads is usually distributed as shapefiles with LINESTRINGs. This gem will convert continuous data (LINESTRING) to discrete points (POINT).

Road Roller does the following
1) Converts a road into 'n' points separated by a distance 'd'
2) Creates a new lane 'l' for a given road at a distance 'd' (Yet to be implemented)



```ruby
require 'road_roller'
filename = "/home/user/roads.shp"
road_roller = RoadRoller.new(filename, 'id')
road_roller.divide_roads_into_points(1)
road_roller.export_to_csv()
```


