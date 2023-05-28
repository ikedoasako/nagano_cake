class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    binding.pry
    @order = Order.new(order_params)
    @order.payment_method = params[:order][:payment_method]
    @order.shipping_cost = 800
    @cart_items = current_customer.cart_items
    @sum = 0
    @order = 
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
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
      params.require(:order).permit( :postal_code, :address, :name, :payment_method) #登録（new）で必要なものだけ
  end

end
