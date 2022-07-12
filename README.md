# README

## Dependencies
- ruby
- yarn
- sqlite

## Rubyバージョン 
- `.ruby-version`を参照してください

## 環境構築
- GitHubを操作して自分のリポジトリにこのリポジトリをforkした後自分のローカル環境にcloneしてください

``` 
$ bundle install
$ bin/rails db:setup
$ yarn
```

## 起動
それぞれ別タブで起動する必要があります

```
$ bin/rails s
```

```
$ bin/webpack-dev-server
```

## テスト

``` 
$ bundle exec rspec
```

## 課題提出方法
- プルリクエストを作成し、カリキュラムからレビュー依頼を行ってください
