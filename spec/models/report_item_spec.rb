require 'rails_helper'

RSpec.describe ReportItem, type: :model do
  describe 'validations' do 
    it { should belong_to :report }
    it { should belong_to :item }
  end

  describe 'relationships' do 
    it { should belong_to :report }
    it { should belong_to :item }
  end

  describe 'methods' do 
    describe 'link_report_items' do 
      it 'creates a many to many relationship' do 
        report = create(:report)
        report_2 = create(:report)
        items = create_list(:item, 5)
        items_2 = create_list(:item, 3)
        item_ids = items.map(&:id)
        item_2_ids = items_2.map(&:id)

        expect(ReportItem.count).to eq(0)

        report_items = ReportItem.link_report_items({
          report_id: report.id,
          item_ids: item_ids
        })

        report_items_2 = ReportItem.link_report_items({
          report_id: report_2.id,
          item_ids: item_2_ids
        })

        report_result = Report.find(report.id)
        report_2_result = Report.find(report_2.id)

        expect(ReportItem.count).to eq(8)

        # make sure that report.items have different counts
        expect(report_result.items.count).to eq(5)
        expect(report_2_result.items.count).to eq(3)
      end
    end
  end
end
