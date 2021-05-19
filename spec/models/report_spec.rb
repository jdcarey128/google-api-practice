require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'validations' do 
    it { should validate_presence_of :average_price }
  end

  describe 'relationships' do 
    it { should belong_to(:user) }
    it { should have_many(:report_items) }
    it { should have_many(:items).through :report_items }
  end

  describe 'methods' do 
    describe 'generate_report' do
      before :each do 
        @items = create_list(:item, 5, school: 'school-1')
        @items_2 = create_list(:item, 5, school: 'school-2')
        @items_3 = create_list(:item, 5, school: 'school-3')
        @item_ids = [@items.map(&:id), @items_2.map(&:id)].flatten
        @user = create(:user)
      end
      
      it 'should create a report with the average unit price of all items' do 
        report = Report.generate_report(@user.id, @item_ids)

        expect(report).to be_a(Report)
        expect(report.items.count).to eq(10)
        expect(report.items[0]).to be_a(Item)
      end
    end
  end
end
