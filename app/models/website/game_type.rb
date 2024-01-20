# frozen_string_literal: true

module Website
  # == Schema Information
  #
  # Table name: game_types
  #
  #  id         :uuid             not null, primary key
  #  name       :string(120)
  #  icon_path  :string
  #  created_at :datetime         not null
  #  updated_at :datetime         not null
  #
  class GameType < ApplicationRecord
    validates :name, presence: true, length: { minimum: 2, maximum: 120 }

    def self.collection
      all.map { |gt| [gt.name, gt.id] }
    end
  end
end
