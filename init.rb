# Include hook code here
require File.dirname(__FILE__) + '/lib/acts_as_metrical'
ActiveRecord::Base.send(:include, ActiveRecord::Acts::Metrical)