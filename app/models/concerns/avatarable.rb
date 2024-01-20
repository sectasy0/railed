# frozen_string_literal: true

# Avatarable
#
# This module provides a utility method for generating SVG-based avatars with initials.
# It can be included in classes that need to generate avatar SVGs based on user names or other input.
module Avatarable
  extend ActiveSupport::Concern

  # Generates an SVG avatar with initials based on the provided parameters.
  #
  # @param size [Integer] The width and height of the SVG avatar.
  # @param font_size [Integer] The font size of the initials inside the avatar.
  # @param extra_classes [String] Additional CSS classes for styling the SVG avatar.
  # @param name [String] The name used to extract initials for the avatar.
  # @return [String] The SVG content for the avatar.
  def letters_svg(size: 32, font_size: 14, extra_classes: 'rounded-full h-8 w-8 text-gray-600')
    letters = name.is_a?(String) ? name.split.map(&:first).join.upcase[0..1] : ''
    svg_content = <<~SVG
      <?xml version="1.0" encoding="UTF-8"?>
      <svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="#{size}" height="#{size}" viewBox="0 0 #{size} #{size}" class="#{extra_classes}">
        <rect width="100%" height="100%" fill="currentColor" />
        <text fill="#fff" font-size="#{font_size}" font-weight="500" x="50%" y="55%" dominant-baseline="middle" text-anchor="middle">
          #{letters}
        </text>
      </svg>
    SVG
    svg_content.html_safe
  end
end
