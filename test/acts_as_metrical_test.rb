require 'test_helper'

class ActsAsMetricalTest < ActiveSupport::TestCase
  
  load_schema 
  
  test "schema has loaded" do
    assert_equal 3, MetricThing.all.size  
  end 
  
  test "verify type" do
    harry = metric_things(:snake)
    
    assert_equal 1.0.to_f.class, harry.diameter_in_mm.class
  end
    
  test "verify values" do
    harry = metric_things(:snake)
    bob = metric_things(:bus)
    carl = metric_things(:ant)
    
    # mm
    assert_equal 10, harry.diameter
    assert_equal 2700, bob.diameter
    assert_equal 0.3, carl.diameter
    
    # cm
    assert_equal 10, harry.height
    assert_equal 4000, bob.height
    assert_equal 0.5, carl.height
    
    # m
    assert_equal 2.5, harry.length
    assert_equal 5, bob.length
    assert_equal 0.001, carl.length
    
    # km
    assert_equal 100, harry.distance_travelled
    assert_equal 100000, bob.distance_travelled
    assert_equal 0.1, carl.distance_travelled
    
  end
  
  test "base unit" do
    harry = metric_things(:snake)
    bob = metric_things(:bus)
    carl = metric_things(:ant)
    

    assert_equal :mm, harry.diameter_base_unit
    assert_equal :mm, bob.diameter_base_unit
    assert_equal :mm, carl.diameter_base_unit
    
    # cm
    assert_equal :cm, harry.height_base_unit
    assert_equal :cm, bob.height_base_unit
    assert_equal :cm, carl.height_base_unit
    
    # m
    assert_equal :m, harry.length_base_unit
    assert_equal :m, bob.length_base_unit
    assert_equal :m, carl.length_base_unit
    
    # km
    assert_equal :km, harry.distance_travelled_base_unit
    assert_equal :km, bob.distance_travelled_base_unit
    assert_equal :km, carl.distance_travelled_base_unit
    
  end
  
  test "output in mm" do
    harry = metric_things(:snake)
    bob = metric_things(:bus)
    carl = metric_things(:ant)
    
     # mm -> mm
    assert_equal 10, harry.diameter_in_mm
    assert_equal 2700, bob.diameter_in_mm
    assert_equal 0.3, carl.diameter_in_mm
    
    # cm -> mm
    assert_equal 100, harry.height_in_mm
    assert_equal 40000, bob.height_in_mm
    assert_equal 5, carl.height_in_mm
    
    # m -> mm
    assert_equal 2500, harry.length_in_mm
    assert_equal 5000, bob.length_in_mm
    assert_equal 1, carl.length_in_mm
    
    # km -> mm
    assert_equal 100000000, harry.distance_travelled_in_mm
    assert_equal 100000000000, bob.distance_travelled_in_mm
    assert_equal 100000, carl.distance_travelled_in_mm
  end
  
  test "output in cm" do
    harry = metric_things(:snake)
    bob = metric_things(:bus)
    carl = metric_things(:ant)
    
    # mm -> cm
    assert_equal 1, harry.diameter_in_cm
    assert_equal 270, bob.diameter_in_cm
    assert_equal 0.03, carl.diameter_in_cm
    
    # cm -> cm
    assert_equal 10, harry.height_in_cm
    assert_equal 4000, bob.height_in_cm
    assert_equal 0.5, carl.height_in_cm
    
    # m -> cm
    assert_equal 250, harry.length_in_cm
    assert_equal 500, bob.length_in_cm
    assert_equal 0.1, carl.length_in_cm
    
    # km -> cm
    assert_equal 10000000, harry.distance_travelled_in_cm
    assert_equal 10000000000, bob.distance_travelled_in_cm
    assert_equal 10000, carl.distance_travelled_in_cm
  end
  
  test "output in m" do
    harry = metric_things(:snake)
    bob = metric_things(:bus)
    carl = metric_things(:ant)
    
    # mm -> m
    assert_equal 0.01, harry.diameter_in_m
    assert_equal 2.70, bob.diameter_in_m
    assert_equal 0.0003, carl.diameter_in_m
    
    # cm -> m
    assert_equal 0.10, harry.height_in_m
    assert_equal 40, bob.height_in_m
    assert_equal 0.005, carl.height_in_m
    
    # m -> m
    assert_equal 2.5, harry.length_in_m
    assert_equal 5, bob.length_in_m
    assert_equal 0.001, carl.length_in_m
    
    # km -> m
    assert_equal 100000, harry.distance_travelled_in_m
    assert_equal 100000000, bob.distance_travelled_in_m
    assert_equal 100, carl.distance_travelled_in_m
  end
  
  test "output in km" do
    harry = metric_things(:snake)
    bob = metric_things(:bus)
    carl = metric_things(:ant)
    
    # mm -> km
    assert_equal 0.00001, harry.diameter_in_km
    assert_equal 0.00270, bob.diameter_in_km
    assert_equal 0.0000003, carl.diameter_in_km
    
    # cm -> km
    assert_equal 0.0001, harry.height_in_km
    assert_equal 0.04, bob.height_in_km
    assert_equal 0.000005, carl.height_in_km
    
    # m -> km
    assert_equal 0.0025, harry.length_in_km
    assert_equal 0.005, bob.length_in_km
    assert_equal 0.000001, carl.length_in_km
    
    # km -> km
    assert_equal 100, harry.distance_travelled_in_km
    assert_equal 100000, bob.distance_travelled_in_km
    assert_equal 0.1, carl.distance_travelled_in_km
  end
  
  test " input in mm" do
    harry = metric_things(:snake)
   
    # mm -> mm
    assert_equal 10, harry.diameter_in_mm
    harry.diameter_in_mm = 15
    assert_equal 15, harry.diameter_in_mm
    assert_equal 15, harry.diameter
     
    # mm -> cm
    assert_equal 100, harry.height_in_mm
    harry.height_in_mm = 50
    assert_equal 50, harry.height_in_mm
    assert_equal 5, harry.height_in_cm
    assert_equal 5, harry.height
    
    # mm -> m
    assert_equal 2500, harry.length_in_mm
    harry.length_in_mm = 2000
    assert_equal 2000, harry.length_in_mm
    assert_equal 2, harry.length_in_m
    assert_equal 2, harry.length
    
    # mm -> km
    assert_equal 100000000, harry.distance_travelled_in_mm
    harry.distance_travelled_in_mm = 500000000
    assert_equal 500, harry.distance_travelled_in_km
    assert_equal 500, harry.distance_travelled
 end
 
  test " input in cm" do
    harry = metric_things(:snake)
   
    # cm -> mm
    assert_equal 1, harry.diameter_in_cm
    harry.diameter_in_cm = 2
    assert_equal 2, harry.diameter_in_cm
    assert_equal 20, harry.diameter_in_mm
    assert_equal 20, harry.diameter
     
    # cm -> cm
    assert_equal 10, harry.height_in_cm
    harry.height_in_cm = 50
    assert_equal 50, harry.height_in_cm
    assert_equal 50, harry.height
    
    # cm -> m
    assert_equal 250, harry.length_in_cm
    harry.length_in_cm = 200
    assert_equal 200, harry.length_in_cm
    assert_equal 2, harry.length_in_m
    assert_equal 2, harry.length
    
    # cm -> km
    assert_equal 10000000, harry.distance_travelled_in_cm
    harry.distance_travelled_in_cm = 20000000
    assert_equal 20000000, harry.distance_travelled_in_cm
    assert_equal 200, harry.distance_travelled_in_km
    assert_equal 200, harry.distance_travelled
  end
  
  test "input in m" do
    harry = metric_things(:snake)
   
    # m -> mm
    assert_equal 0.01, harry.diameter_in_m
    harry.diameter_in_m = 0.02
    assert_equal 0.02, harry.diameter_in_m
    assert_equal 20, harry.diameter_in_mm
    assert_equal 20, harry.diameter
     
    # m -> cm
    assert_equal 0.10, harry.height_in_m
    harry.height_in_m = 0.20
    assert_equal 0.20, harry.height_in_m
    assert_equal 20, harry.height_in_cm
    assert_equal 20, harry.height
    
    # m -> m
    assert_equal 2.5, harry.length_in_m
    harry.length_in_m = 3.2
    assert_equal 3.2, harry.length_in_m
    assert_equal 3.2, harry.length
    
    # m -> km
    assert_equal 100000, harry.distance_travelled_in_m
    harry.distance_travelled_in_m = 200000
    assert_equal 200000, harry.distance_travelled_in_m
    assert_equal 200, harry.distance_travelled_in_km
    assert_equal 200, harry.distance_travelled
    
  end
  
  test "input in km" do
    harry = metric_things(:snake)
    
    # km -> mm
    assert_equal 0.00001, harry.diameter_in_km
    harry.diameter_in_km = 0.00002 
    assert_equal 0.00002, harry.diameter_in_km
    assert_equal 20, harry.diameter_in_mm
    assert_equal 20, harry.diameter
    
    # km -> cm
    assert_equal 0.0001, harry.height_in_km
    harry.height_in_km = 0.0002
    assert_equal 0.0002, harry.height_in_km
    assert_equal 20, harry.height_in_cm
    assert_equal 20, harry.height
    
    # km -> m
    assert_equal 0.0025, harry.length_in_km
    harry.length_in_km = 0.0026
    assert_equal 0.0026, harry.length_in_km
    assert_equal 2.6, harry.length_in_m
    assert_equal 2.6, harry.length
    
    # km -> km
    assert_equal 100, harry.distance_travelled_in_km
    harry.distance_travelled_in_km = 200
    assert_equal 200, harry.distance_travelled_in_km
    assert_equal 200, harry.distance_travelled
  end
  
  test " methods returning numeric" do
    harry = metric_things(:snake)
    
    assert_equal 5, harry.return_numeric
    assert_equal :m, harry.return_numeric_base_unit
    assert_equal 5000, harry.return_numeric_in_mm
    assert_equal 500, harry.return_numeric_in_cm
    assert_equal 5, harry.return_numeric_in_m
    
    assert_raise(NoMethodError){ harry.return_numeric_in_mm = 5 }
    assert_raise(NoMethodError){ harry.return_numeric_in_cm = 5 }
    assert_raise(NoMethodError){ harry.return_numeric_in_m = 5 }
    assert_raise(NoMethodError){ harry.return_numeric_in_km = 5 }
    
  end
  
  test " methods returning invalid values" do
    harry = metric_things(:snake)
    
    assert_equal "5", harry.return_string
    assert_equal :m, harry.return_string_base_unit
    assert_raise(ActiveRecord::Acts::Metrical::Errors::InvalidReturnError){ harry.return_string_in_mm }
    assert_raise(ActiveRecord::Acts::Metrical::Errors::InvalidReturnError){ harry.return_string_in_cm }
    assert_raise(ActiveRecord::Acts::Metrical::Errors::InvalidReturnError){ harry.return_string_in_m }
    assert_raise(ActiveRecord::Acts::Metrical::Errors::InvalidReturnError){ harry.return_string_in_km }
    
    assert_raise(NoMethodError){ harry.return_string_in_mm = 5 }
    assert_raise(NoMethodError){ harry.return_string_in_cm = 5 }
    assert_raise(NoMethodError){ harry.return_string_in_m = 5}
    assert_raise(NoMethodError){ harry.return_string_in_km = 5 }
        
  end
  
end
