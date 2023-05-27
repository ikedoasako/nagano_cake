class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end
  
  def confirm
    @order = current_customer.order
    
    
  end
  
  def completion
  end

  def index
  end

  def show
  end

  def create
  end
  
  private
  
  def order_params
      params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end

end
