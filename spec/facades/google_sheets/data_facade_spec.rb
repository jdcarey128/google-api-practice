require 'rails_helper'

describe 'Google Sheets Data Facade' do
  describe 'fetch sheet data' do 
    it 'returns a report object' do
      response_data = JSON.parse(File.read('spec/fixtures/google_sheet_data.json'), symbolize_names: true)[:results]
      token = ENV['SUPER_SECRET_TOKEN']
      user = create(:user)

      # helper method found in rails helper
      open_struct_data = create_open_struct(response_data)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(GoogleSheets::ReportsService).to receive(:fetch_sheet_data).with(token, 10).and_return(open_struct_data)
      
      result = GoogleSheets::ReportsFacade.fetch_sheet_data(token, 10, user.id)

      expect(result).to be_a(Report)
      first_item = result.items[0]
      expect(first_item).to be_a(Item)
      expect(first_item.id).to eq(4)
    end
  end
end
