class Public::HomesController < ApplicationController
  
  def top
    @items = Item.order('id DESC').limit(4)
    @items = Item.page(params[:page])
  end

  def about
  end
  
end
