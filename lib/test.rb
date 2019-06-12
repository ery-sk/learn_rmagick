require 'RMagick' # require してライブラリを読み込み

img = Magick::ImageList.new('app/assets/images/sample.png') # 元画像の sample.jpg を読み込み
new_img = img.blur_image(20.0, 10.0) # ブラーエフェクトを適用　戻り値に新しい画像が戻るよ
new_img.write('app/assets/images/processed/blur.png') # ファイルに書き出し
