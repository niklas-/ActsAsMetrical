module ActiveRecord
  module Acts
    module Metrical
      module Errors
        class ActsAsMetricalError < RuntimeError; end
        class InvalidReturnError < ActsAsMetricalError; end
      end
    end
  end
end