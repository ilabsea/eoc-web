class SopsController < ApplicationController
  def index
    @sop_highlights = Sop.search_highlight(params)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @sop = Sop.new
  end

  def create
    @sop = Sop.new(sop_params)
    if @sop.save
      redirect_to sops_url
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

    if @sop.update_attributes(sop_params)
      if params[:sop][:remove_file] == '1'
        @sop.remove_file!
        @sop.save
      end

      redirect_to sops_url
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
    send_file "#{Rails.root}/public/#{params[:file]}", disposition: 'attachment'
  end

  def upload
  end

  def import
    render :import unless params[:zip_file]
    
    file = File.open(params[:zip_file].path)
    uploader = FileUploader.new
    uploader.store! file

    service = SpreadsheetService.new uploader.path
    service.unzip do |excels|
      excels.each do |excel|
        excel.load
      end
    end

    redirect_to sops_path, notice: 'Import success!'
  end

  private

  def sop_params
    params.require(:sop).permit(
      :name, :category_id, :file, :tags
    )
  end
end
