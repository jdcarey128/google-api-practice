require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do 
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'methods' do 
    before :each do 
      @omniauth_data = JSON.parse(File.read('spec/fixtures/omniauth_data.json'))
    end

    it 'should create user when they don\'t exist' do
      expect(User.count).to eq(0)
      user = User.from_google_omniauth(@omniauth_data)
      expect(User.count).to eq(1)
      expect(User.find(user.id)).to eq(user)
    end

    it 'should find user when they exist' do 
      user_info = @omniauth_data['info']
      created_user = create(:user, 
                    first_name: user_info['first_name'],
                    last_name: user_info['last_name'],
                    email: user_info['email'],
                    image: user_info['image'],
                  )
      expect(User.count).to eq(1)
      found_user = User.from_google_omniauth(@omniauth_data)
      expect(User.count).to eq(1)
      expect(created_user).to eq(found_user)
    end
  end
end
