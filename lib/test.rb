# frozen_string_literal: true

# require してライブラリを読み込み
require 'RMagick'

# 元画像の sample.jpg を読み込み
img = Magick::ImageList.new('app/assets/images/sample.png')
# ブラーエフェクトを適用
new_img = img.blur_image(20.0, 10.0)
# ファイルに書き出し
new_img.write('app/assets/images/processed/blur.png')

# 処理が終わって書き出したものに関しては明示的にメモリを解放するのが好ましい
new_img.destroy!
