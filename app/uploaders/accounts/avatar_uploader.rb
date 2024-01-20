# frozen_string_literal: true

module Accounts
  # Custom uploader class designed to handle avatar image uploads.
  class AvatarUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file
    process resize_to_fit: [150, 150]

    def store_dir
      'uploads/avatars'
    end

    def size_range
      0..(1.megabytes)
    end

    def extension_allowlist
      %w[jpg jpeg png]
    end

    def filename
      "#{model.id}.#{file&.extension}" if file
    end
  end
end
