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
