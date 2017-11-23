source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.6'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'haml-rails'

group :developement, :test do
  gem 'byebug', platform: :mri

  # RSpec
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'

  # サンプルデータ生成
  gem 'faker'

  # テストのカバレッジ計測
  gem 'simplecov'

  # UIテスト
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'

  # デバッグ
  gem 'pry-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # n+1問題検知
  gem 'bullet'

  # エラー画面変更
  gem 'better_errors'
  gem 'binding_of_caller'

  # 速度計測
  gem 'rack-mini-profiler'

  # haml変換
  gem 'erb2haml'
end

# windows対応
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
