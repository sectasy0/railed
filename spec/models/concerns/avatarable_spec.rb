# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Avatarable do
  let(:account) { accounts(:first) }

  describe '#letters_svg' do
    it 'returns an svg of initials' do
      svg = account.letters_svg
      expect(svg).to include('J')
    end
  end
end
