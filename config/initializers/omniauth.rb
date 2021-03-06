Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:get]
  OmniAuth.config.silence_get_warning = true
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
    {
      scope: 'userinfo.email, userinfo.profile, https://www.googleapis.com/auth/spreadsheets, https://www.googleapis.com/auth/drive.file'
    }
end
