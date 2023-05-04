class Public::CustomersController < ApplicationController
  
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update
      flash[:notice] = "You have updated user successfully"
        redirect_to customers_my_page_path
    else
      render :edit
    end
  end

  def unsubscribed
    @customer = current_customer
  end

  def withdraw
  end
end
