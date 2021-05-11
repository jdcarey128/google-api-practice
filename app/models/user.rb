class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true 
  validates_presence_of :first_name, :last_name

  class << self 
    def from_google_omniauth(omniauth_data)
      user_info = omniauth_data['info']
      User.find_or_create_by({
        first_name: user_info['first_name'],
        last_name: user_info['last_name'],
        email: user_info['email'],
        image: user_info['image']
      })
    end
  end
end
