# gemspec.rb

#require File.expand_path("../lib/road_roller/version", __FILE__)

Gem::Specification.new do |s|

s.name        = "road_roller"

s.version     = '0.0.1'

s.platform    = Gem::Platform::RUBY

s.authors     = ["Sagar Arlekar"]

s.email       = ["sagar.arlekar@gmail.com"]

s.homepage    = "https://github.com/sagarlekar/road_roller"

s.summary     = "A ruby gem to manipulate road(MULTILINE) spatial data."

s.description = "Road Roller is a GIS gem to manipulate road(MULTILINE) spatial data. 
Spatial data for roads is usually distributed as shapefile with MULTILINEs. Converting continuous data (MULTILINE) to discrete (POINT) form will make it suitable for running Agent Based Simulations, especially in transportation and motion simulations.

Road Roller does the following
1) Convert roads into 'n' points separated by a distance 'd'
2) Create a new lane 'l' for a given roads at a distance 'd'"

#s.required_rubygems_version = "&gt;= 1.3.6"

# required for validation

s.rubyforge_project         = "road_roller"

# If you have other dependencies, add them here

# s.add_dependency "another", "~&gt; 1.2"

# If you need to check in files that aren't .rb files, add them here

s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]

s.require_path = 'lib'

# If you need an executable, add it here

# s.executables = ["newgem"]

# If you have C extensions, uncomment this line

# s.extensions = "ext/extconf.rb"

end
