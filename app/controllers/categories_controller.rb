class CategoriesController < ApplicationController

  def index
    @all_categories = Category.all.order_by_name
  end

  def new
    @category = Category.new
    @all_categories = Category.all.order_by_name
  end

  def create

  end
  def edit
    @category = Category.find(params[:id])
    @all_categories = Category.all.order_by_name
  end

  def update

  end

  def destroy

  end
end
