module Spree
  module Admin
    class ThemesPreviewController < Spree::Admin::BaseController

      skip_before_action :authorize_admin
      before_action :load_theme, only: [:show, :destroy]

      def show
        cookies[:preview] = @theme.name
        @theme.open_preview
        redirect_to root_path(theme: @theme.id, mode: 'preview')
      end

      def destroy
        cookies[:preview] = { value: nil, expires: Time.now }
        @theme.close_preview
        redirect_to admin_themes_path
      end

      private

        def load_theme
          @theme = Spree::Theme.find_by(id: params[:theme_id])
          unless @theme
            redirect_to admin_themes_path
          end
        end

    end
  end
end
