require 'rails_helper'

describe 'Reports Index' do 
  before :each do 
    stub_omniauth
    user = User.from_google_omniauth(stub_omniauth)

    # Build user reports
    @report_1 = create(:report, user: user)
    @item_1 = create(:item)
    @item_2 = create(:item)
    @report_item_1 = create(:report_item, report_id: @report_1.id, item_id: @item_1.id)
    @report_item_2 = create(:report_item, report_id: @report_1.id, item_id: @item_2.id)
    
    @report_2 = create(:report, user: user)
    @report_item_3 = create(:report_item, report_id: @report_2.id, item_id: @item_2.id)

    # report not to be seen with user 
    report_item = create(:report_item)
    @report_not_to_see = report_item.report
    @item_not_to_see = report_item.item

    visit root_path 
    click_on 'Log in with Google'
    
    visit reports_path
  end
  
  it 'displays all past reports for a user' do 
    expect(current_path).to eq(reports_path)

    within('.reports') do 
      expect(page).to have_css('.report', count: 2)
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@report_1.average_price)
      expect(page).to have_content(@report_2.average_price)

      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.unit_price)
      expect(page).to have_content(@item_1.merchant_id)

      # not have 
      expect(page).to_not have_content(@report_not_to_see.average_price)
      expect(page).to_not have_content(@item_not_to_see.name)
    end
  end

  it 'allows user to display report show page' do 
    click_link "Report: #{@report_2.id}"

    expect(current_path).to eq(report_path(@report_2))

    expect(page).to have_css('.report', count: 1)
  end

  it 'has a link back to dashboard' do 
    click_link 'Return to Dashboard' 
    expect(current_path).to eq(dashboard_path)
  end
end
