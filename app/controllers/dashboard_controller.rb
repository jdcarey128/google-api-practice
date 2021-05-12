class DashboardController < ApplicationController
  before_action :require_login

  def show
    @user = current_user
  end

  def get_data
    token = session[:token]
    DataService.get_data(token)
  end
  
end
