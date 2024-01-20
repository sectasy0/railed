# frozen_string_literal: true

# This is the base class for all models in the application. It inherits from ActiveRecord::Base
# and provides common functionality or configurations that are shared across all models.
class ApplicationRecord < ActiveRecord::Base
  # Marks this class as an abstract primary class.
  primary_abstract_class
end
