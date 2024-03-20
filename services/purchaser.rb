class Purchaser
  def initialize
  end

  def purchase(order, params)
    # Fake number to force a decline
    order.paid = params[:credit_card_number] != "4242424242424242"
    order.save
    true
  end
end
