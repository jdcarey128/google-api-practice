class ReportItem < ApplicationRecord
  belongs_to :report
  belongs_to :item
  class << self 
    def link_report_items(ids)
      ids[:item_ids].each do |item_id|
        ReportItem.create(
          report_id: ids[:report_id],
          item_id: item_id
        )
      end
    end
  end
end
