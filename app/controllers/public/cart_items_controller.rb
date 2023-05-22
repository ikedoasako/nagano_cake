class Public::CartItemsController < ApplicationController

  def index
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items
    @sum = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
      flash[:notice] = "追加しました"
      redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  def create
    #byebug
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.item_id = params[:cart_item][:item_id]
    @cart_item.save
    redirect_to cart_items_path
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
