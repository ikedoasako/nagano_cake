class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    #binding.pry
    @order = Order.new(order_params)
    @order.payment_method = params[:order][:payment_method]
    @order.shipping_cost = 800 #送料の金額指定
    @cart_items = current_customer.cart_items
    @sum = 0 #0からスタートして足されていく
    @order.save
  end

  def completion
    @order = current_customer.order
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
