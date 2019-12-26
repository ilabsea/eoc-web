# frozen_string_literal: true

class UploadsController < ApplicationController
  def index
  end

  def validate
    if params[:zip_file] && params[:zip_file].content_type == "application/zip"
      service = SopImportService.new(compress_file: params[:zip_file])
      @result = service.validate
      render partial: "validate", locals: { result: @result, destination: service.destination }
    else
      flash[:alert] = t("views.uploads.invalid_import_file")
      redirect_to uploads_path
    end
  end

  def import
    service = SopImportService.new(destination: import_params[:destination])
    service.process
    render partial: "success", locals: {}
  end

  private
    def import_params
      params.permit(:destination)
    end
end
