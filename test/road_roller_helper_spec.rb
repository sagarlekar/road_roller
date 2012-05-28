# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'road_roller_helper'


describe RoadRollerHelper do

  before(:each) do

  end

  it "length of line should be < 10" do
    #puts "Length = " +  RoadRollerHelper::get_line_length(1,0,4,3,1).to_s
    RoadRollerHelper::get_line_length(1,0,4,3,1).should < 10
  end

end

