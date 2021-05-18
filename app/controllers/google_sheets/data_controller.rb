module GoogleSheets
  class DataController < ApplicationController
    before_action :require_login

    caches_action :index, expires_in: 0.10.hour

    def index 
      token = session[:token]
      count = params[:record_count].to_i
      # returns report object with accessible items 
      @report = GoogleSheets::DataFacade.fetch_sheet_data(token, count)
    end

  end
end 
