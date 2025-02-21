# ベースイメージとして Ruby 3.4.1 を使用
FROM ruby:3.4.1

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# アプリの作業ディレクトリを設定
WORKDIR /app

# Gemfile をコンテナにコピー
COPY Gemfile Gemfile.lock ./

# Bundler を実行（Gem をインストール）
RUN bundle install

# アプリのソースコードをコンテナにコピー
COPY . .

# サーバーを起動する
CMD ["rails", "server", "-b", "0.0.0.0"]
