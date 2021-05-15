class DashboardController < ApplicationController
  before_action :require_login

  def show
    @user = current_user
  end

  # def get_range
  #   token = session[:token]
  #   @data = DataFacade.get_range(token)
  # end
  
end
