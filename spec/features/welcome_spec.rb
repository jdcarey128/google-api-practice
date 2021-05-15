require 'rails_helper'

describe 'Welcome Page' do 
  before :each do 
    stub_omniauth
    visit root_path 
  end

  it 'takes you to welcome page' do
    expect(page).to have_content('Welcome')
  end

  it 'has log in with Google link' do 
    click_link 'Log in with Google'
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Hello')
  end

  it 'redirects you to dashboard once logged in' do
    click_link 'Log in with Google'
    expect(current_path).to eq(dashboard_path)
    visit root_path
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('You are already logged in')
  end
end
