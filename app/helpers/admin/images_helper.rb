module Admin::ImagesHelper
  def file_size(image)
    number_with_precision(image.data_file_size / 1024.0, precision: 2) + "kb"
  end
end