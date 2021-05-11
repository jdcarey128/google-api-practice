module OmniauthMacros
  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      {
        "provider": "google_oauth2",
        "uid": "1",
        "info": 
         {
          "name": "Joshua Carey",
          "email": "jdcarey128@gmail.com",
          "unverified_email": "jdcarey128@gmail.com",
          "email_verified": true,
          "first_name": "Joshua",
          "last_name": "Carey",
          "image": "https://lh3.googleusercontent.com/-kqGmu-P5-WY/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuclk2PmeS8Y7L_muMqizTWLXSUA5ag/s96-c/photo.jpg"
        },
        "credentials": 
        {
          "token": ENV['SUPER_SECRET_TOKEN'],
          "expires_at": 1620682524,
          "expires": true
        }
      }
    )
  end
end
