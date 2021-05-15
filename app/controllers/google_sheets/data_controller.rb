module GoogleSheets
  class DataController < ApplicationController
    before_action :require_login

    caches_action :index, expires_in: 0.10.hour

    def index 
      token = session[:token]
      count = params[:record_count].to_i
      @data = GoogleSheets::DataFacade.fetch_sheet_data(token, count=10)
    end

  end
end 
