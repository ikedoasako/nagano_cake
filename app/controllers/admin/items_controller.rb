class Admin::ItemsController < ApplicationController

  def new
    @items = Item.new

  end

  def create
    @items = Item.new(item_params)
    @items.save
    redirect_to admin_item_path(@items.id)
  end

  def show
    @items = Item.all
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.page(params[:page])
  end

  def edit
    @item = Item.find(params[:id])
    redirect_to admin_item_path(@items.id)
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price)
  end

end
