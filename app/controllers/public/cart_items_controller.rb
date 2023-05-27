class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer! #ログインしているユーザーにしか下記の動きをしないようにする記述（:authenticate_customer!）

  def index
    @cart_item = CartItem.new #商品を入れるため、登録するための空のカートを作る
    @cart_items = current_customer.cart_items #カート内商品＝ログインしているユーザーのカート内商品
    @sum = 0 #合計金額
  end

  def update
    @cart_item = CartItem.find(params[:id]) #カート内商品＝カートモデルに保存されている顧客のカート情報を探してくる
    @cart_item.update(cart_item_params) #カート内商品の更新（数量追加）するために（カート内商品の情報を渡す)
      flash[:notice] = "商品を追加しました"
      redirect_to cart_items_path　#保存ができたらカート内商品一覧画面に戻ってくる
  end

  def destroy
    @cart_item = CartItem.find(params[:id]) #カート内商品＝カートモデルに保存されている情報から顧客のカートに入っている商品を探してくる
    @cart_item.destroy #カート内商品の削除
    redirect_to cart_items_path #カート内商品一覧画面に戻る
  end

  def destroy_all
    @cart_item = current_customer.cart_items #カート内商品＝ログインしているユーザーのカート内商品
    @cart_item.destroy_all #カート内商品の全ての商品を削除する
    redirect_to cart_items_path　#カート内商品一覧画面に戻る
  end

  def create
    #byebug
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]) #item_idはカラム、:cart_item,:item_idは値
      #カートアイテムは、ログインしているユーザーの、カート内商品の、現在のカート内に入っている商品の情報を探してくる
    if cart_item　#上でcart_itemについて記述している内容がそのまま入っている
      sum = cart_item.amount +  params[:cart_item][:amount].to_i #sumは計算、現在のカート内商品の数量に←カートに追加された商品と数量を足す（左の内容を右へ送っている）
      cart_item.update_attribute(:amount, sum) #updateの後に値が2つあり、カンマで区切っているのでupdate_attribute（updateだとエラー出た）1つだったらupdate
    else
      @cart_item = CartItem.new(cart_item_params) #商品を入れるための空っぽのカートを用意する（CartItem.new）
      @cart_item.customer_id = current_customer.id　#商品カートの顧客の情報は、ログインしている顧客の情報
      @cart_item.item_id = params[:cart_item][:item_id] #商品カートの商品＝[カート内に商品がどれだけ入っているか]と[入っている商品が何か]の情報
      @cart_item.save #カートの内容を保存する
    end
    redirect_to cart_items_path #カート内商品一覧ページに戻る
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount, :customer_id)
      #(:cart_item)がカラム、(:item_id, :amount)は値
  end

end
