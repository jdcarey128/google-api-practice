module GoogleSheets
  class ReportsController < ApplicationController
    before_action :require_login

    caches_action :index, expires_in: 0.5.hour, cache_path: -> { request.params[:record_count] }

    def index 
      token = session[:token]
      count = params[:record_count].to_i
      # returns report object with accessible items 
      @report = GoogleSheets::ReportsFacade.fetch_sheet_data(token, count)
    end

  end
end 
