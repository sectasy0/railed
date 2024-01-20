# frozen_string_literal: true

NavLink = Struct.new(:title, :path, keyword_init: true) do
  def self.all
    YAML.load_file(Rails.root.join('data', 'nav_links.yml'))
        .map(&:with_indifferent_access)
        .map { |link_data| new(**link_data) }
  end
end
