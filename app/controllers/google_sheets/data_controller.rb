module GoogleSheets
  class DataController < ApplicationController
    
    def index 
      token = session[:token]
      # collect additional params as necessary (eg. range, average, etc)
      @data = GoogleSheets::DataFacade.fetch_sheet_data(token)
    end
  end
end 
