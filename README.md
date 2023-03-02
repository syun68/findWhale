# FindWhale:whale2:

海洋生物の写真投稿サイトです。  
野生の海洋生物情報を位置情報付きで共有できます。  
レスポンシブ対応しておりますので、スマホ・タブレットでもご覧いただけます。

## 使用技術
* Ruby 3.1.2
* Ruby on Rails 7.0.4
* MySQL 5.7.41
* Nginx
* Unicorn
* AWS
  * VPC
  * EC2
  * VPC Endpoint
  * S3
* Docker/Docker-compose
* Circle CI/CL
* RSpec
* Google Maps API

## AWS構成図
![AWS概要図](https://user-images.githubusercontent.com/101915651/221893845-e1fe1062-7b45-4f00-ad4f-9b8aaaad6a2c.png)
#### CircleCi CI/CD
* GitHubへのPush時にRspecが自動で実施されます。

## 機能一覧
* ユーザー登録
  * 画像アップロード
* ログイン機能
* 投稿機能
  * 画像アップロード
  * 位置情報機能(geocoder)
* 検索機能

## テスト
* RSpec
  * 単体テスト(model)
  * 機能テスト(request)
  * 統合テスト(system)
