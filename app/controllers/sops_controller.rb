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

    if @sop.update_attributes(data)
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
    @sop.destroy

    redirect_to sops_url
  end

  def download
    send_file "#{Rails.root}/public/#{params[:file]}", disposition: "attachment"
  end

  def upload
  end

  def import
    if params[:zip_file]
      file = File.open(params[:zip_file].path)
      uploader = ZipUploader.new
      uploader.store! file

      service = SpreadsheetService.new uploader.path
      service.unzip do |excels|
        excels.each do |excel|
          excel.load
        end
      end

      redirect_to upload_sops_path, notice: 'Import success!'
    else
      render :upload
    end
  end

  private
    def sop_params
      params.require(:sop).permit(
        :name, :category_id, :file, :tags, :description, :remove_file
      )
    end
end
