class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm

    @order = Order.new(order_params)
    @order.payment_method = params[:order][:payment_method]
    @order.shipping_cost = 800 #送料の金額指定
    @sum = 0 #0からスタートして金額足されていく

    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name

    @cart_items = current_customer.cart_items #カート内商品の情報を取得
    #@order_new = Order.new #hidden_fieldを作るのに使う
  end


  def completion #ページ表示するだけ
  end

  def create
    order = Order.new(order_params)
    order.save
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
    @order_detail = OrderDetail.new
    @order_detail.order_id = order.id
    @order_detail.item_id = cart_item.item_id
    @order_detail.price = cart_item.item.with_tax_price
    @order_detail.amount = cart_item.amount
    @order_detail.save
    #binding.pry

    end

    @cart_items.destroy_all

    redirect_to orders_completion_path
  end

  def index
    @orders = Order.all
    @order = Order.new
    @order_detail.order_id = order.id
    @order_detail.item_id = cart_item.item.id
  end

  def show
    @order = Order.find(params[:id])

  end

  private

  def order_params
      params.require(:order).permit( :postal_code, :address, :name, :payment_method, :customer_id, :shipping_cost, :total_payment)
  end

end
