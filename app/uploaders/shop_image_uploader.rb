class ShopImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  Rails.env.production? ? (storage :fog) : (storage :file)

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
