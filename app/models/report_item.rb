class ReportItem < ApplicationRecord
  belongs_to :report
  belongs_to :item
end
