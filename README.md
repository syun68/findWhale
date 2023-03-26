# FindWhale:whale2:

海洋生物の写真投稿サイトです。    
レスポンシブ対応しておりますので、スマホ・タブレットでもご覧いただけます。  
![ホーム画面](https://user-images.githubusercontent.com/101915651/226985730-39598dbc-606d-42d5-94e0-096e12eb92ab.gif)
_You can see this app on [AWS](http://35.76.100.10/)_

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
* Rubocop
* RSpec
* Google Maps API

## インストール方法
1. homebrewのインストール  
```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"```

2. Dockerのインストール  
```brewupdate```  
```brew install --cask docker```

3. Dockerの起動  
```open/Applications/Docker.Applications```

4. プロジェクトのclone  
```git clone https://github.com/syun68/findWhale.git```

5. docker-compose up  
```docker-compose up --build```

6. アクセス  
ブラウザから[http://localhost:3000/](http://localhost:3000/)へアクセス

## AWS構成図
![AWS概要図](https://user-images.githubusercontent.com/101915651/222487401-62eca152-ed02-4ee9-8dd1-2013b90e2c68.png)
#### CircleCi CI/CD
* GitHubへのPush時にRubocopとRspecが自動で実施されます。

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

## 作成動機
ホエールウォッチングで味わえる感動を共有したくて作成しました。

## こだわりポイント
Google Maps APIと連携することにより、投稿場所を視覚的に見れるようにしました。
![map](https://user-images.githubusercontent.com/101915651/226990754-8ab4c420-5b61-45ef-acbc-71e0ae335807.gif)
