class OrdersController < ApplicationController
  before_action :get_child, only: [ :new, :create ]

  def new
    @order = Order.new(product: Product.find(params[:product_id]))
  end

  def create
    values_from_old_order = {}
    
    # Only create a new child if we aren't already shopping for one in the system
    if @child.present?
      # Get the previous order details based on the original order that created the child
      # This is a simplified use case. In reality we would use a general address set for a child 
      # since addresses can change over time
      old_order = @child.orders.order(:id).first
      
      # Working on the assumption if a child is in the systme there is at least one order.
      # There should be more complexity / error checking here since the previous code could create children and fail on the order
      values_from_old_order = old_order.attributes.slice("shipping_name", "address", "zipcode")
    else
      @child = Child.find_or_create_by(child_params.merge(user_facing_id: SecureRandom.uuid))
      # Note: Should check that the child was successfully created, or even better see note about nested attributes below
    end
    @order = Order.create(order_params.merge(child: @child, user_facing_id: SecureRandom.uuid[0..7]).merge(values_from_old_order))
    if @order.valid?
      Purchaser.new.purchase(@order, credit_card_params)
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def show
    # Note: Allowing id: as an alternative is a security hole
    # Note 2: Bad Ids will cause a crash since there isn't error handling
    @order = Order.find_by(id: params[:id]) || Order.find_by(user_facing_id: params[:id])
  end

private

  # Note: This can be cleaned up using rails nested attributes in a form so the child model is built at
  # the same time as the order model. See here for an example: https://www.pluralsight.com/guides/ruby-on-rails-nested-attributes
  # Using nested attributes 1) prevents creating a child when the order will fail 2) Allows you to return all 
  # the failed validations at once and will simplify this controller's code.
  
  def order_params
    params.require(:order).permit(:shipping_name, :product_id, :zipcode, :address, :giver_name, :gift_message).merge(paid: false)
  end

  def child_params
    {
      full_name: params.require(:order)[:child_full_name],
      parent_name: params.require(:order)[:shipping_name],
      birthdate: Date.parse(params.require(:order)[:child_birthdate]), # Note: This will crash if the field is left blank
    }
  end

  def credit_card_params
    params.require(:order).permit( :credit_card_number, :expiration_month, :expiration_year)
  end
end
