class OrdersController < ApplicationController
  def new
    @order_form = OrderForm.new(form_params)
  end

  def create
    @order_form = OrderForm.new(form_params)

    if @order_form.submit
      redirect_to order_path(@order_form.order)
    else
      render :new
    end
  end

  def show
    @order = Order.find_by(id: params[:id]) || Order.find_by(user_facing_id: params[:id])
  end

private

  def product_id
    params[:product_id] || params[:order_form][:product_id]
  end

  def form_params
    params.fetch(:order_form, {})
          .permit(
            :shipping_name, :parent_full_name, :product_id,
            :zipcode, :address, :child_full_name,
            :shipping_name, :gift, :gift_message, :child_birthdate,
            :credit_card_number, :expiration_month, :expiration_year
          ).tap { |prms| prms[:product_id] ||= params[:product_id] }
  end
end
