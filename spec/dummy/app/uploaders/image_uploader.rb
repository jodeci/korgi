# frozen_string_literal: true
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def cache_dir
    "#{Rails.root}/public/uploads/tmp"
  end

  def store_dir
    "#{Rails.root}/public/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large do
    process resize_to_limit: [800, 800]
  end

  version :medium, from_version: :large do
    process resize_to_limit: [500, 500]
  end

  version :thumb, from_version: :medium do
    process resize_to_fill: [100, 100]
  end
end
