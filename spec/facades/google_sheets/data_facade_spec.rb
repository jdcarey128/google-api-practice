require 'rails_helper'

describe 'Google Sheets Data Facade' do
  describe 'fetch sheet data' do 
    it 'returns an array of Open Struct data objects' do
      response_data = JSON.parse(File.read('spec/fixtures/google_sheet_data.json'), symbolize_names: true)[:results]
      token = ENV['SUPER_SECRET_TOKEN']

      # helper method found in rails helper
      open_struct_data = create_open_struct(response_data)

      allow(GoogleSheets::DataService).to receive(:fetch_sheet_data).with(token).and_return(open_struct_data)
      
      result = GoogleSheets::DataFacade.fetch_sheet_data(token)

      expect(result).to be_a(Array)

      first_result = result[0]
      
      expect(first_result).to be_a(OpenStruct)
      expect(first_result.school).to eq('school 1')

      values = first_result.values
      expect(values).to be_a(Array)

      first_value_set = values[0]
      expect(first_value_set[0]).to eq('id')
      expect(first_value_set[1]).to eq('name')
      expect(first_value_set[2]).to eq('description')
      expect(first_value_set[3]).to eq('unit_price')
      expect(first_value_set[4]).to eq('merchant_id')
      expect(first_value_set[5]).to eq('created_at')
      expect(first_value_set[6]).to eq('updated_at')
    end
  end
end
