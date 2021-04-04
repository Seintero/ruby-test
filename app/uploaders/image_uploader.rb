class ImageUploader < CarrierWave::Uploader::Base
  # TODO: tests
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  process resize_to_fit: [540, 400]

  version :thumb do
    process resize_to_fill: [200,200]
  end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  def size_range
    0..1.megabytes
  end

  def filename
    name = File.basename("#{original_filename}", ".*")
    Services::Translate.cyr_to_lat(name) + '.' + model.image.file.extension if original_filename.present?
  end
end
