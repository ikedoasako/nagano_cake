class Public::CustomersController < ApplicationController
  
  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
    redirect_to customer_path(@customer.id)
  end

  def update
  end

  def unsubscribed
  end

  def withdraw
  end
end
