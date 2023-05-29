class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    #binding.pry
    @order = Order.new(order_params)
    @order.payment_method = params[:order][:payment_method]
    @order.shipping_cost = 800 #送料の金額指定
    @sum = 0 #0からスタートして足されていく
    
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
    
    @cart_items = current_customer.cart_items #カート内商品の情報を取得
    @order_new = Order.new #hidden_fieldを作るのに使う
  end

  def completion
    @order = current_customer.order
  end

  def index
    @order_details = OrderDetail.new
    @order_details.order_id = order.id
    @order_details.item_id = cart_item.item.id
  end

  def show
  end

  def create
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @order.save
    render :completion
  end

  private

  def order_params
      params.require(:order).permit( :postal_code, :address, :name, :payment_method) #登録（new）で必要なものだけ
  end

end
