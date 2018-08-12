class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

	before_save :set_price_and_calculate_total

	after_save :set_orders_total!

  validate :apt_quantity

	def set_orders_total!
		order.save!
	end

	def set_price_and_calculate_total
		self.price = product.price
		self.total = price * quantity
	end

	def apt_quantity
		@qty ||= product.availables.find_by(store: order.store).quantity

    errors.add :quantity, 'is invalid' unless quantity.in?(1..@qty)
	end
end
