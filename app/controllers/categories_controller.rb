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

  def move
    category = Category.find(move_params[:category_id])
    parent_category = Category.find(move_params[:parent_id])
    if category.move_to_child_of(parent_category)
      redirect_to category_path(parent_category.id)
    else
      flash.now[:alert] = @category.errors.full_messages
    end
  end

  def move_sop
    sop = Sop.find(move_params[:sop_id])
    parent_category = Category.find(move_params[:parent_id])
    if sop.update(category_id: move_params[:parent_id])
      redirect_to category_path(parent_category.id)
    else
      flash.now[:alert] = sop.errors.full_messages
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

  def move_params
    params.require(:category).permit(:parent_id, :category_id, :sop_id)
  end
end

