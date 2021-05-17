require 'rails_helper'

describe 'Google Sheets Index' do
  describe 'when logged in with Google Oauth' do 
    before :each do 
      stub_omniauth
      visit root_path 
      click_link'Log in with Google'
      @token = ENV['SUPER_SECRET_TOKEN']
    end

    it 'displays the user\'s sheet data for a range' do 
      response_data = JSON.parse(File.read('spec/fixtures/google_sheet_data.json'), symbolize_names: true)
      # this creates the open struct object that occurs in data service
      open_struct_data = create_open_struct(response_data[:results])
      allow(GoogleSheets::DataService).to receive(:fetch_sheet_data).with(@token, 10).and_return(open_struct_data)
      
      click_on 'Fetch Google Sheet Data' 
      
      expect(current_path).to eq(google_sheets_data_path)
      expect(page).to have_content('data')
      expect(page).to have_content('ID')
      expect(page).to have_content('Description')
      expect(page).to have_content('Unit Price')
      expect(page).to have_content('Merchant ID')
      expect(page).to have_content('Created At')

      within (".summary") do 
        expect(page).to have_content("$37,379.67")
      end
      
      # specific data from fixture[0]
      within (".items") do 
        expect(page).to have_content("school-1")
        expect(page).to have_content("4")
        expect(page).to have_content("Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.")
        expect(page).to have_content("4291")
        expect(page).to have_content("1")
      end
    end
  end
end
