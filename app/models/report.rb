class Report < ApplicationRecord
  validates :average_price, presence: true
end
