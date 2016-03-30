module Spree
  module Admin
    class ThemesController < Spree::Admin::BaseController

      after_action :clear_cache, only: :update

      def update
        Spree::Config[:theme_name] = params[:theme][:name]
        redirect_to action: :show
      end

      private
        def clear_cache
          Rails.cache.clear
        end

    end
  end
end
