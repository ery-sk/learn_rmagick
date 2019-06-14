# RMagickで遊ぶ

https://rmagick.github.io/

## 準備

imagemagickのインストール

```sh
$ brew install imagemagick
```

ImageMagickには脆弱性がたくさんあるので  
/usr/local/Cellar/imagemagick/7.0.8-48/etc/ImageMagick-7/policy.xml を編集する  
...と思ったら初期値の状態で既に追加されてた。  
逆に PNG,JPEG,GIF,WEBP 拡張子以外でも受け取りたくなった場合は以下を修正するとよい。

参考: https://qiita.com/yoya/items/2076c1f5137d4041e3aa

```xml
<policy domain="delegate" rights="none" pattern="*" />
<policy domain="filter" rights="none" pattern="*" />
<policy domain="coder" rights="none" pattern="*" />
<policy domain="coder" rights="read|write" pattern="{PNG,JPEG,GIF,WEBP}" />
```

RMagicをインストールする

```rb
gem 'rmagick'
```
```sh
$ bundle
```

## 動作確認

lib/test.rb 参照

## formで複数の画像を送信して保存する

```sh
rails g controller images
```

```rb
# routes.rb
Rails.application.routes.draw do
  resources :images, only: %i[new create]
end
```

```rb
# images_controller.rb
class ImagesController < ApplicationController
  def new; end

  def create
    File.binwrite('public/image_1.png', params[:image_1].read)
    File.binwrite('public/image_2.png', params[:image_2].read)
  end
end
```

```erb
<%# images/new.html.erb %>
<%= form_with url: images_path do |f| %>
  <%= f.file_field :image_1 %>
  <%= f.file_field :image_2 %>
  <%= f.submit %>
<% end %>
```

<img width="606" alt="form" src="https://user-images.githubusercontent.com/38872854/59412660-e252e500-8df8-11e9-8110-9959b4536d09.png">

送信すると public 以下に保存されている

## 取得した画像を連結して保存する

```rb
# images_controller.rb
class ImagesController < ApplicationController
  def new; end

  def create
    images = Magick::ImageList.new(params[:image_1].tempfile.path, params[:image_2].tempfile.path)
    images.append(false).write('public/join.png')
  end
end
```

## 取得した画像を規定の場所に重ねて合成して保存する
```rb
# images_controller.rb
class ImagesController < ApplicationController
  def new; end

  def create
    base_image = Magick::Image.from_blob(params[:image_1].read).first
    addition_image = Magick::Image.from_blob(params[:image_2].read).first
    image = base_image.composite(addition_image, 0, 0, Magick::OverCompositeOp)
    image.write('public/pile_up.png')
  end
end
```
