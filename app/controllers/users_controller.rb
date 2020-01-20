# frozen_string_literal: true

class UsersController < ApplicationController
  def update_locale
    current_user.locale = locale_params[:locale]
    if current_user.save
      head :ok
    else
      render json: current_user.errors.messages
    end
  end

  private
    def locale_params
      params.require(:user).permit(:locale)
    end
end
