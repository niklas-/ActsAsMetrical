class MetricThing < ActiveRecord::Base
  acts_as_metrical :return_numeric => :m, :return_string => :m, :diameter => :mm, :height => :cm,  :length => :m,  :distance_travelled => :km
  
  def return_numeric()
    5
  end
  
  def return_string()
    "5"
  end
end