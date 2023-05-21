class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @cart_items = current_customer.cart_items
  end

  def update
    @cart_items = CartItem.find(params[:id])
    if @cart_items.update(cart_item_params)
      flash[:notice] = "追加しました"
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy
  end

  def destroy_all
  end

  def create
    #byebug
    @cart_items = CartItem.new(cart_item_params)

  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
