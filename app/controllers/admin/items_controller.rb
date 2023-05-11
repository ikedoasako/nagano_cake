class Admin::ItemsController < ApplicationController

  def new
    @items = Item.new

  end

  def create
    @items = Item.new(item_params)
    @items.save
    redirect_to admin_item_path(@items.id)
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price)
  end

end
