module SpreeThemes
  class Engine < Rails::Engine
    require 'spree/core'
    require_relative '../extensions/dir'
    isolate_namespace Spree
    engine_name 'spree_themes'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "asset_paths" do |app|
      Dir.human_entries(Rails.root.join('vendor', 'themes')).each do |theme_name|
        Rails.application.config.assets.paths.insert(8,
          Rails.root.join('vendor', 'themes', theme_name, 'javascripts').to_s,
          Rails.root.join('vendor', 'themes', theme_name, 'stylesheets').to_s,
          Rails.root.join('vendor', 'themes', theme_name, 'images').to_s,
          Rails.root.join('vendor', 'themes', theme_name, 'fonts').to_s,
          Rails.root.join('vendor', 'themes', theme_name, 'logo').to_s
        )
      end
    end

    initializer "asset_paths" do |app|
      Rails.application.config.assets.paths.insert(8,
        Rails.root.join('vendor', 'themes').to_s)
    end

    initializer "spree_themes.assets.precompile" do |app|
      FileUtils.mkdir_p(Rails.root.join('vendor', 'themes'))
      Dir.human_entries(Rails.root.join('vendor', 'themes')).each do |theme_name|
        app.config.assets.precompile += Dir.glob(Rails.root.join('vendor', 'themes', theme_name, 'stylesheets', 'spree', '**', '*.css'))
        app.config.assets.precompile += Dir.glob(Rails.root.join('vendor', 'themes', theme_name, 'stylesheets', 'spree', '**', '*.scss'))
        app.config.assets.precompile += Dir.glob(Rails.root.join('vendor', 'themes', theme_name, 'javascripts', 'spree', '**', '*.js'))
        app.config.assets.precompile += Dir.glob(Rails.root.join('vendor', 'themes', theme_name, 'javascripts', 'spree', '**', '*.js.coffee'))
        app.config.assets.precompile += Dir.glob(Rails.root.join('vendor', 'themes', theme_name, 'logo', '*.png'))
      end
      config.assets.precompile << /\.(?:svg|eot|woff|ttf|woff2|gif|png|jpg)\z/
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare do
      Spree::StoreController.helper Spree::GlobalHelper
    end

    config.to_prepare &method(:activate).to_proc
    Devise.parent_controller = 'Spree::StoreController'
  end
end
