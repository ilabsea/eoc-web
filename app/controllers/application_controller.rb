# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  around_action :switch_locale

  layout :layout_by_resource

  def default_url_options
    { locale: params[:locale] || I18n.default_locale }
  end

  private
    def layout_by_resource
      devise_controller? ? "minimal" : "application"
    end

    def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale
      I18n.with_locale(locale, &action)
    end
end
