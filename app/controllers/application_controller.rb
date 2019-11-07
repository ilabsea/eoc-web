# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!

  layout :layout_by_resource

  private
    def layout_by_resource
      devise_controller? ? "minimal" : "application"
    end
end
