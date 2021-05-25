class Item < ApplicationRecord
  validates :name, :description, :unit_price, :school, :merchant_id, presence: true
  has_many :report_items 
  has_many :reports, through: :report_items
  scope :scoped_items, ->(ids) { where("id IN (?)", ids)}

  class << self 
    # returns array of ids from created or found items
    def items_from_sheets(school_items)
      school_items.map do |items_values|
        items_values.values[1..-1].map do |values|
          begin
            Item.find_or_create_by(
              id: values[0],
              name: values[1],
              description: values[2],
              unit_price: values[3].to_f,
              merchant_id: values[4].to_i,
              school: items_values.school
            ).id
          rescue ActiveRecord::RecordNotUnique
            item = Item.find(values[0])
            item.update(
              name: values[1],
              description: values[2],
              unit_price: values[3].to_f,
              merchant_id: values[4].to_i,
              school: items_values.school
            ).id
          end
        end
      end.flatten!
    end
  end
end
