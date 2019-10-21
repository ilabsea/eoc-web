class CategoriesController < ApplicationController
  def index
    @sub_categories = Category.roots
    @sops = Sop.where(category_id: nil)
  end

  def new
    @category = Category.new(parent_id: params[:parent_id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_path(@category)
    else
      flash.now[:alert] = @category.errors.full_messages
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @sub_categories = @category.children
    @sops = Sop.where(category_id: params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end

