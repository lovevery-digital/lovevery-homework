class OrdersController < ApplicationController
  def new
    @order = Order.new(product: Product.find(params[:product_id]))
    @order.is_guest = params[:is_guest]
  end

  def create
    @order = order_by_guest_or_parent
    if @order && @order.valid?
      Purchaser.new.purchase(@order, credit_card_params)
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def order_by_guest_or_parent
    by_guest = order_params[:is_guest]
    if by_guest.present?
      child = Child.find_by(child_params)
      return Order.new unless child
      last_order = Order.where(orderable_id: child.id).last # for the Address
      guest = Guest.create(guest_params.merge(child: child))
      order = Order.create(order_params.merge(orderable: guest, user_facing_id: SecureRandom.uuid[0..7], address: last_order.address, zipcode: last_order.zipcode))
    else
      child = Child.find_or_create_by(child_params)
      order = Order.create(order_params.merge(orderable: child, user_facing_id: SecureRandom.uuid[0..7]))
      puts order.id
    end
    order
  end

  def show
    @order = Order.find_by(id: params[:id]) || Order.find_by(user_facing_id: params[:id])
  end

private

  def order_params
    params.require(:order).permit(:shipping_name, :product_id, :zipcode, :address, :is_guest, :message).merge(paid: false)
  end

  def child_params
    {
      full_name: params.require(:order)[:child_full_name],
      parent_name: params.require(:order)[:shipping_name],
      birthdate: Date.parse(params.require(:order)[:child_birthdate]),
    }
  end

  def guest_params
    { name: params.require(:order)[:guest_name] }
  end

  def credit_card_params
    params.require(:order).permit( :credit_card_number, :expiration_month, :expiration_year)
  end
end
