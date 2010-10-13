# ActsAsMetrical
module ActiveRecord
  module Acts #:nodoc:
    module Metrical #:nodoc:
      
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_metrical(options = {})
          extend ActiveRecord::Acts::Metrical::SingletonMethods
          include ActiveRecord::Acts::Metrical::InstanceMethods
          
          # define dynamicaly instance methods
          options.each do |method, db_unit|
            ["mm", "cm", "m", "km"].each do |method_unit|
              new_method = method.to_s + "_in_" + method_unit 
              define_getter(method.to_s, new_method, db_unit, method_unit)
              define_get_baseunits(method.to_s, db_unit)
              define_setter(method.to_s, new_method, db_unit, method_unit)    
            end  
          end
        end
      end # end ClassMethods
      
      module SingletonMethods
        
        protected
        
        def define_getter(method, method_name, db_unit, output_unit)
          
          # start method body
          proc = lambda do
            value =  self.send(method)
            # All values need to be Numeric
            if value.is_a? Numeric and ratio_to_mm(output_unit).is_a? Numeric and ratio_to_mm(db_unit.to_s).is_a? Numeric
              # The converted value is the ratio between the output unit and the unit stored in the database
              result = (BigDecimal.new(value.to_s) * (ratio_to_mm(output_unit) / ratio_to_mm(db_unit.to_s))).to_f
            else
              raise ActiveRecord::Acts::Metrical::Errors::InvalidReturnError
            end 
            result
          end # end method body
          
          define_method(method_name, &proc) unless proc.nil?
        end
        
        def define_get_baseunits(method_name, db_unit)
          proc = lambda do
           db_unit
          end 
          define_method(method_name + "_base_unit", &proc) unless proc.nil?
        end
          
        def define_setter(method, method_name, db_unit, input_unit)
          
          # start method body
          proc = lambda do |parameter|
            if parameter.is_a? Numeric and ratio_to_mm(input_unit).is_a? Numeric and ratio_to_mm(db_unit.to_s).is_a? Numeric
              # The converted value is the ratio between the unit stored in the database and the inbut unit 
              parameter = parameter * ( ratio_to_mm(db_unit.to_s) / ratio_to_mm(input_unit)) 
              result = self.send(method + "=", parameter )
            end
          end # end method body
          
          define_method(method_name + "=", &proc) unless proc.nil?
        end
      end # end SingletonMethods 
    
      
      module InstanceMethods
          
        protected
  
        def ratio_to_mm(unit)  
          multiplicator = case unit
            when "mm" then BigDecimal.new("1.0")
            when "cm" then BigDecimal.new("0.1")
            when "m" then BigDecimal.new("0.001")
            when "km" then BigDecimal.new("0.000001")
            else "not defined"
          end
          multiplicator
        end 

      end # end InstanceMethods
    end # end metrical
  end # end acts
end
