# frozen_string_literal: true

# Server car for admin dashboard
class RecaptchableComponent < ApplicationComponent
  option :target
  option :v2_fallback, default: false
end
