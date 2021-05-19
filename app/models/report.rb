class Report < ApplicationRecord
  validates :average_price, presence: true
  belongs_to :user
  has_many :report_items
  has_many :items, through: :report_items

  class << self 
    def generate_report(user_id, item_ids)
      avg_unit_price = Item.scoped_items(item_ids)
                           .average(:unit_price)
      report = Report.create(
        user_id: user_id,
        average_price: avg_unit_price
      )
      ReportItem.link_report_items({report_id: report.id, item_ids: item_ids})
      return report 
    end

    def user_reports(user_id)
      Report.where('user_id = ?', user_id)
    end
  end
end
