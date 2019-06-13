class ImagesController < ApplicationController
  def index; end

  def new; end

  def create
    images = Magick::ImageList.new(params[:image_1].tempfile.path, params[:image_2].tempfile.path)
    images.append(false).write('public/join.png')
  end
end
