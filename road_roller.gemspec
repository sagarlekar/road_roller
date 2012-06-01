# gemspec.rb

Gem::Specification.new do |s|

s.name        = "road_roller"

s.version     = '0.1.0'

s.platform    = Gem::Platform::RUBY

s.authors     = ["Sagar Arlekar"]

s.email       = ["sagar.arlekar@gmail.com"]

s.homepage    = "https://github.com/sagarlekar/road_roller"

s.summary     = "A ruby gem to convert road(MULTILINE) spatial data into points(Point)."

s.description = "Road Roller pre-processes spatial data for Roads Networks. This makes it suitable for use in Agent Based Simulations, especially in transportation and motion simulations.
Spatial data for roads is usually distributed as shapefiles with LINESTRINGs. This gem will convert continuous data (LINESTRING) to discrete points (POINT)."

Road Roller does the following
1) Convert roads into 'n' points separated by a distance 'd'
2) Create a new lane 'l' for a given roads at a distance 'd'"

s.rubyforge_project         = "road_roller"

s.add_dependency 'rgeo', '>=0.3.13'

s.add_dependency 'rgeo-shapefile', '>=0.2.3'

s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]

s.require_path = 'lib'

end
