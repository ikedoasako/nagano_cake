class Admin::HomesController < ApplicationController
  
  def top
    @items = Item.page(params[:item])end

end
