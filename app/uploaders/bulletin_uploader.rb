# frozen_string_literal: true

class BulletinUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :preview_update_image do
    process resize_to_fill: [67, 100]
  end

  def size_range
    (1.byte)..(2.megabytes)
  end
end
