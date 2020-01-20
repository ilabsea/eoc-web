# frozen_string_literal: true

class UploadsController < ApplicationController
  def index
  end

  def validate
    if params[:zip_file] && params[:zip_file].content_type == "application/zip"
      begin
        service = SopImportService.new(compress_file: params[:zip_file])
        @result = service.validate
        render partial: "validate", locals: { result: @result, destination: service.destination, step: Constant::VALIDATE_STEP }
      rescue RuntimeError, Zip::Error => e
        flash[:alert] = e.message
        render partial: "upload", locals: { step: Constant::UPLOAD_STEP }
      end
    else
      flash[:alert] = t("views.uploads.invalid_import_file")
      render partial: "upload", locals: { step: Constant::UPLOAD_STEP }
    end
  end

  def import
    service = SopImportService.new(destination: import_params[:destination])
    service.process
    render partial: "success", locals: { step: Constant::COMPLETE_STEP }
  end

  private
    def import_params
      params.permit(:destination)
    end
end
