class Admin::HomesController < ApplicationController
  
  def top
    @item = Item.find(params[:id])
  end

end
