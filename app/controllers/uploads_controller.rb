# frozen_string_literal: true

class UploadsController < ApplicationController
  def index
  end

  def validate
    if params[:zip_file] && params[:zip_file].content_type == "application/zip"

    else
      flash[:alert] = t("views.uploads.invalid_import_file")
      redirect_to uploads_path
    end
  end
end
