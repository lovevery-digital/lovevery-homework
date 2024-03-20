module Orders
  class Creator
    def self.call(*args)
      new(*args).call
    end

    def initialize(order_form:)
      @order_form = order_form
    end

    def call


    end

    private

    def child_params
      {
        full_name: order_form.child_full_name,
        parent_name: order_form.shipping_name,
        birthdate: Date.parse(order_form.child_birthdate),
      }
    end

    def child
      @child = Child.find_or_create_by(child_params)
    end

    def order
      @order = Order.create(order_params.merge(child: child, user_facing_id: SecureRandom.uuid[0..7]))
    end
  end
end
