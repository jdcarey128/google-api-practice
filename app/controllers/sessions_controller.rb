class SessionsController < ApplicationController

  def GoogleAuth
    omniauth_data = request.env['omniauth.auth']
    # send omniauth user info to either create or find user 
    user = User.from_google_omniauth(omniauth_data)

    session[:user_id] = user.id
    session[:token] = omniauth_data[:credentials][:token]
    
    redirect_to dashboard_path
  end

  def destroy 
    # delete session data 
    reset_session()
    redirect_to root_path
  end
end
