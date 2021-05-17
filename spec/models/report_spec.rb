require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'validations' do 
    it { should validate_presence_of :average_price }
  end
end
