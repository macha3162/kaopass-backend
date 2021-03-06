# KaoPass Backend

イベントのチェックインを、手書き認識と顔認証でおこなえるようにしたiOSアプリのバックエンドです。  
このアプリケーションはRailsで作られています。  
実行するためには、このアプリケーションと[KaoPassアプリ](https://github.com/macha3162/kaopass-ios)を実行する必要があります。

### アプリケーションの概要


操作はiOSアプリで行います。  
アプリの動画は[こちら](https://vimeo.com/232448592)からご覧になれます。

#### イベント新規登録
iPadまたはiPhoneの画面に手書きで名前を入力し、次に興味のあるセッションを選びます。  
なんとそれだけ！以上でチェックインは完了です。

![KaoPass新規登録](https://media.giphy.com/media/6ekYTjQ5Gx4D6/giphy.gif "新規登録")



#### イベント再入場
顔写真を撮影すると顔の分析を行います。  
イベント登録のあったユーザは、手書き入力された名前を読み上げつつ、選んだセッションが表示されます。  
登録のない人は、入場禁止画面が表示されます。

![KaoPass再入場](https://media.giphy.com/media/DqWgTaUIAbv4A/giphy.gif "再入場")


### バックエンド
どのセッションにどれだけ申し込みがあるのか、どの時間帯に入場が多かったのか等を表示するダッシュボード画面があります。  
この画面は申し込みがある度に、自動で更新されるようになっています。RailsのActionCableを使って実現しています。  
また、アプリ側に表示されるイベント情報を編集することが出来ます。


## 利用するRubyのバージョン
2.4.1を推奨。（ただし、2.2.2以上であれば可）

## 依存する外部アプリケーション

* [Redis](https://redis.io/)
  * ActiveJobの実行に利用
* AWS
  * [Amazon Rekognition](https://aws.amazon.com/jp/rekognition/)
    * 顔認識で利用
    * 初めて使用する方は、最初の12か月間は、1か月あたり 5,000 枚の画像分析と、毎月最大 1,000 個の顔メタデータの保存が可能
    * リージョンは東京には対応していないので、オレゴンを選択
  * [Amazon S3](https://aws.amazon.com/jp/s3/)
    * 顔写真の保存に利用
    * 顔分析で利用するので、Rekognitionと同じリージョンに作成するのが良い
* [MyScript](https://www.myscript.com/?lang=ja)
  * 手書き認識で利用

# 動作させるための準備

ここでの説明は、KaoPassのバックエンドの構築手順です。
KaoPassアプリを動かすためには、iOSアプリの設定も必要となります。


## 外部サービスの登録

### Amazon Web Service
Amazon RekognitionとS3を利用するため、両サービスにアクセス可能なIAMを作成し、以下のキーを取得します。

* access_key_id
* secret_access_key

S3に画像を保存するためのバケットを作成しておいてください。


### MyScript

手書き入力を利用するため、以下のサイトからDeveloper登録を行い、以下のキーを取得します。


[MyScript Developer Site](https://developer.myscript.com/)

* applicationkey
* hmackey

## Railsのセットアップ

このリポジトリをフォークし、ローカルにcloneしたら、次のコマンドでセットアップを実行してください。  
※ Dockerを利用する場合には後ほど実行します。  

```
bin/setup
```

### 設定ファイルの書き換え

設定ファイルをローカル用にコピーし、編集を行います。
```
cp config/settings.yml config/settings.local.yml
vi config/settings.local.yml
```

```
# AWSのIAMの設定を保存する
aws:
  access_key_id:
  secret_access_key:
  region: us-west-2 # RekognitionとS3のリージョン
  bucket: s3bucket # 画像を保存するバケット名
  collection_id: face_collection # 顔識別グループを保存する名前、なんでもよい

# MyScriptで取得したキーを設定
myscript:
  applicationkey:
  hmackey:

signature_cdn_base: ''
```


## Docker利用の場合

以下のコマンドで環境が整います。  
初回のみ setup コマンドを実行して環境を整えてください。 その後 http://localhost:3000/ にアクセス可能になります。  

```
docker-compose up -d
docker-compose run web bin/setup # 初回のみ実行
```

## サーバの起動

セットアップを実行したらRailsを起動し、 http://localhost:3000/ にアクセスします。  
正常にダッシュボード画面が表示されればOKです。

```
rails s -p 3000 -b 0.0.0.0
```

## Sidekiqの起動

顔分析を行なうためのバックグラウンドJobを実行するために、Sidekiqを起動します。  
ローカルでRedisが動いていることが前提です。

```
bundle exec sidekiq
```

## アプリの接続

起動したサーバにアプリを接続します。
KaoPassアプリのリポジトリは[こちら](https://github.com/macha3162/kaopass-ios)。

## お問い合わせ

何か不明な点があれば、[@macha3162](https://twitter.com/macha3162)までご連絡ください。


## License
[Supported by Synergy Marketing, Inc.](https://synergist.jp/)
Licensed under [MIT](LICENSE).