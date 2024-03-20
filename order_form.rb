class OrderForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  # ATTRIBUTES
  # ---------------------

  attribute :product_id, :integer
  attribute :shipping_name, :string
  attribute :child_full_name, :string
  attribute :gift, :boolean
  attribute :gift_message, :string
  attribute :child_birthdate, :date
  attribute :parent_full_name, :string
  attribute :address, :string
  attribute :zipcode, :string
  attribute :credit_card_number, :string
  attribute :expiration_month, :string
  attribute :expiration_year, :string
  attribute :paid, :boolean

  # VALIDATIONS
  # ---------------------

  validates :product, presence: { message: "must exist" }
  validates :parent_full_name, presence: true, if: :gift?
  validates :child, presence: { message: "must exist" }, if: :gift?
  validates :address, :zipcode, presence: true, unless: :gift?
  validates :credit_card_number, :expiration_month, :expiration_year, presence: true

  # METHODS
  # ---------------------

  def gift?
    gift.to_b
  end

  def product
    @product ||= Product.find(product_id)
  end

  def child
    @child ||=
      if gift?
        Child.find_by(child_params)
      else
        Child.find_or_create_by(child_params)
      end
  end

  def child_params
    {
      full_name: child_full_name,
      parent_name: gift? ? parent_full_name : shipping_name,
      birthdate: child_birthdate,
    }
  end

  def previous_order
     @previous_order ||= Order.find_by(child: child, product: product)
  end

  def prev_address_hash
    return {} unless gift?

    previous_order.attributes
                  .with_indifferent_access
                  .slice(:zipcode, :address)
  end

  def order
    @order ||= Order.new(order_params)
  end

  def order_params
    {
      shipping_name: gift? ? parent_full_name : shipping_name,
      product_id: product_id,
      zipcode: zipcode,
      address: address,
      child: child,
      paid: paid&.to_b,
      gift: gift?,
      gift_message: gift_message,
      user_facing_id: SecureRandom.uuid[0..7]
    }.merge(prev_address_hash).compact
  end

  def product=(product)
    @product = product
    product_id = product&.id
  end

  def credit_card_params
    {
      credit_card_number: credit_card_number,
      expiration_month: expiration_month,
      expiration_year: expiration_year
    }
  end

  def submit
    return valid? unless valid?

    if order.valid? && child.valid?
      Purchaser.new.purchase(order, credit_card_params)
    else
      errors.merge order.errors
      errors.merge child.errors
      valid?
    end
  end
end
