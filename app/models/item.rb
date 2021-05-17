class Item < ApplicationRecord
  validates :name, :description, :unit_price, :school, :merchant_id, presence: true
  class << self 
    def items_from_sheets(school_items)
      school_items.map do |items_values|
        items_values.values[1..-1].map do |values|
          Item.find_or_create_by(
            id: values[0],
            name: values[1],
            description: values[2],
            unit_price: values[3].to_f,
            merchant_id: values[4].to_i,
            school: items_values.school
          )
        end
      end
    end
  end
end
