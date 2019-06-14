class OfficialImagesController < ApplicationController
  def index; end

  def new; end

  def create
    base_image = Magick::ImageList.new('public/official_image.png').first
    addition_image = Magick::Image.from_blob(params[:image].read)
                       .first.crop(Magick::CenterGravity, 0, 0, 280, 380)
    image = base_image.composite(addition_image, 11, 59, Magick::OverCompositeOp)
    image.write('public/pile_up.png')
  end
end
