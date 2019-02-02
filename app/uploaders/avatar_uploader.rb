class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  storage Rails.env.production? ? :fog : :file

  version :thumb do
    process resize_to_fill: [300, 300]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg png)
  end

  def content_type_whitelist
    /image\//
  end

end
