require 'rails_helper'

describe 'Dashboard', type: :feature do 
  describe 'when logged in with Google Oauth' do 
    before :each do 
      stub_omniauth
      @token = ENV['SUPER_SECRET_TOKEN']
      visit root_path 
      click_link 'Log in with Google'
    end
    
    it 'allows a user to log out' do 
      expect(current_path).to eq(dashboard_path)
      click_link 'Log out'
      expect(current_path).to eq(root_path)
      visit dashboard_path
      expect(current_path).to eq(root_path)
    end

    it 'displays the user\'s name' do
      name = stub_omniauth['info']['first_name']
      expect(page).to have_content("Hello, #{name}!")
    end

    it 'displays the user\'s sheet data' do 
      response_data = JSON.parse(File.read('spec/fixtures/sheet_data.json'), symbolize_names: true)
      
      allow(DataService).to receive(:get_data).with(@token).and_return(response_data)
      
      click_link 'Get data' 
      
      expect(current_path).to eq(data_path)
      expect(page).to have_content('data')
      expect(page).to have_content('id')
      expect(page).to have_content('description')
      expect(page).to have_content('unit_price')
      expect(page).to have_content('merchant_id')
      expect(page).to have_content('created_at')
      expect(page).to have_content('updated_at')
    end
  end

  describe 'when not logged in with Google Oauth' do 
    it 'redirects visitor to welcome page' do 
      visit dashboard_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Please log in')
    end
  end
end
