class DashboardController < ApplicationController
  before_action :require_login

  def show
    @user = current_user
  end

  def get_data
    token = session[:token]
    @data = DataService.get_data(token)
    @values = @data.values
  end
  
end
