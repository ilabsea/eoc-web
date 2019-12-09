# frozen_string_literal: true

class SopsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @sops = pagy(Sop.includes(:category))
  end

  def show
    @sop = Sop.find(params[:id])
  end

  def new
    @sop = Sop.new(category_id: params[:category_id])
  end

  def create
    data = sop_params
    data[:tags] = data[:tags].split(" ")

    @sop = Sop.new(data)
    if @sop.save
      PushNotificationJob.perform_later("all", data: sop_notification_data)
      redirect_to sop_path(@sop)
    else
      flash.now[:alert] = @sop.errors.full_messages
      render :new
    end
  end

  def edit
    @sop = Sop.find(params[:id])
  end

  def update
    @sop = Sop.find(params[:id])
    data = sop_params
    data[:tags] = data[:tags].split(" ")

    if @sop.update(data)
      if params[:sop][:remove_file] == "1"
        @sop.remove_file!
        @sop.save
      end

      redirect_to sop_path(@sop)
    else
      flash.now[:alert] = @sop.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sop = Sop.find(params[:id])
    category = @sop.category
    @sop.destroy

    url = category.present? ? category_path(category) : categories_path
    redirect_to url
  end

  def download
    send_file "#{Rails.root}/public/#{params[:file]}", disposition: "attachment"
  end

  def upload
  end

  def import
    if params[:zip_file] && params[:zip_file].content_type == "application/zip"
      service = SopImportService.new(params[:zip_file])

      begin
        service.process
        PushNotificationJob.perform_later("all", data: notification_data)
        redirect_to categories_path, notice: "Import success!"
      rescue RuntimeError, Zip::Error => e
        flash[:alert] = e.message
        redirect_to upload_sops_path
      end
    else
      flash[:alert] = "Invalid import file!"
      redirect_to upload_sops_path
    end
  end

  private
    def sop_params
      params.require(:sop).permit(
        :name, :category_id, :file, :tags, :description, :remove_file
      )
    end

    def sop_notification_data
      { 
        itemId: @sop.id,
        title: "New Sop available for download",
        body: "Now you can download \"#{@sop.name}\""
      }
    end

    def notification_data
      {
        title: "New Sop available for download",
        body: "Many new sops are available for download."
      }
    end
end
