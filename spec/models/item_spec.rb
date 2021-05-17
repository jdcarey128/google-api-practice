require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :school }
  end

  describe 'methods' do 
    describe 'create_items_from_sheets' do 
      before :each do 
        sheet_data = JSON.parse(File.read('spec/fixtures/google_sheet_data.json'), symbolize_names: true)
        @items = create_open_struct(sheet_data[:results])
      end
      
      it 'should create items from sheets' do 
        expect(Item.count).to eq(0)
        items = Item.items_from_sheets(@items)

        expect(items).to be_a(Array)
        expect(items[0]).to be_a(Array)
        expect(items[0][0]).to be_a(Item)
        
        expect(Item.count).to eq(12)

        item_5 = Item.find_by(id: 5)
        expect(item_5.name).to eq("Item Expedita Aliquam")
        expect(item_5.unit_price).to eq(68723)
        expect(item_5.school).to eq('school-1')

        item_54 = Item.find_by(id: 54)
        expect(item_54.school).to eq('school-2')
      end

      it 'should find items if they have already been created' do 
        Item.items_from_sheets(@items)
        expect(Item.count).to eq(12)
        Item.items_from_sheets(@items)
        expect(Item.count).to eq(12)
      end
    end
  end
end
