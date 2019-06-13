class ImagesController < ApplicationController
  def index; end

  def new; end

  def create
    base_image = Magick::Image.from_blob(params[:image_1].read).first
    addition_image = Magick::Image.from_blob(params[:image_2].read).first
    image = base_image.composite(addition_image, 0, 0, Magick::OverCompositeOp)
    image.write('public/pile_up.png')
  end
end
