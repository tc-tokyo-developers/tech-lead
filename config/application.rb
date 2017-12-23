require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module TechLead
  class Application < Rails::Application
    # タイムゾーン指定
    config.time_zone = 'Asia/Tokyo'
    # rails-i18nで日本語対応
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja
    config.generators do |g|
      # ヘルパーを自動生成しない
      g.helper false
      # アセットファイルを自動生成しない
      g.assets false
      # RSpecのテストファイル自動生成に関する設定
      g.test_framework :rspec, fixtures: true,
                               controller_specs: true,
                               routing_specs: false,
                               view_specs: false,
                               helper_specs: false,
                               request_specs: false
      # テストデータをfactory_botで生成する
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
    # Bulletの設定
    config.after_initialize do
      Bullet.enable = true
      Bullet.bullet_logger = true
      Bullet.console = true
      Bullet.add_footer = true
    end
  end
end
