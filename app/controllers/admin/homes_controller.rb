class Admin::HomesController < ApplicationController

  def top
    @order =Order.new
    @orders = Order.all
    
    @orders = Order.page(params[:page])
  end

end
