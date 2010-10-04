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
          
          options.each do |method, db_unit|
            ["mm", "cm", "m", "km"].each do |method_unit|
              new_method = method.to_s + "_in_" + method_unit
              define_getter(method.to_s, new_method, db_unit, method_unit)
              define_setter(method.to_s, new_method, db_unit, method_unit)
            end  
          end
        end
      end
      
      module SingletonMethods
        
        protected

        def define_getter(method, method_name, db_unit, output_unit)
          proc = lambda do
            value =  self.send(method)
            # All values need to be Numeric
            if value.is_a? Numeric and ratio_to_mm(output_unit).is_a? Numeric and ratio_to_mm(db_unit.to_s).is_a? Numeric
              # The converted value is the ratio between the output unit and the unit stored in the database
              value * (ratio_to_mm(output_unit) / ratio_to_mm(db_unit.to_s))
            end 
          end
          define_method(method_name, &proc) unless proc.nil?
       end
      
        def define_setter(method, method_name, db_unit, input_unit)
          proc = lambda do |parameter|
            if parameter.is_a? Numeric and ratio_to_mm(input_unit).is_a? Numeric and ratio_to_mm(db_unit.to_s).is_a? Numeric
              # The converted value is the ratio between the unit stored in the database and the inbut unit 
              parameter = parameter * ( ratio_to_mm(db_unit.to_s) / ratio_to_mm(input_unit)) 
              self.send(method + "=", parameter )
            end
          end
          define_method(method_name + "=", &proc) unless proc.nil?
        end
      end

      module InstanceMethods
        
        protected

        def ratio_to_mm(unit)  
          multiplicator = case unit
          when "mm" then 1.0
            when "cm" then 1.0/10
            when "m" then 1.0/1000
            when "km" then 1.0/1000000
            else "not defined"
          end
          multiplicator
        end
      end
      # end InstanceMethods
    end
  end
end
