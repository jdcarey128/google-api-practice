class Item < ApplicationRecord
  validates :name, :description, :unit_price, :school, :merchant_id, presence: true
end
