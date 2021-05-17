require 'rails_helper'

RSpec.describe ReportItem, type: :model do
  describe 'validations' do 
    it { should belong_to :report }
    it { should belong_to :item }
  end
end
