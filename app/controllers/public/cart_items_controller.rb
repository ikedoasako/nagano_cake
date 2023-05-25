class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!　#ログインしているユーザーにしか下記の動きをしないようにする記述（:authenticate_customer!）

  def index
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items
    @sum = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
      flash[:notice] = "商品を追加しました"
      redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  def create
    #byebug
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]) #item_idはカラム、:cart_item,:item_idは値
      #カートアイテムは、ログインしているユーザーの、カート内商品の、現在のカート内に入っている商品の情報を探してくる
    if cart_item　#上でcart_itemについて記述している内容がそのまま入っている
      sum = cart_item.amount +  params[:cart_item][:amount].to_i #sumは計算、現在のカート内商品の数量に←カートに追加された商品と数量を足す（左の内容を右へ送っている）
      cart_item.update_attribute(:amount, sum)　#updateの後に値が2つあり、カンマで区切っているのでupdate_attribute（updateだとエラー出た）1つだったらupdate
    else
      @cart_item = CartItem.new(cart_item_params)　#商品を入れるための空っぽのカートを用意する（CartItem.new）
      @cart_item.customer_id = current_customer.id　#商品カートの顧客の情報は、ログインしている顧客の情報
      @cart_item.item_id = params[:cart_item][:item_id]
      @cart_item.save
    end
    redirect_to cart_items_path
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
