module GoogleSheets
  class DataFacade 
    class << self 
      def fetch_sheet_data(token)
        GoogleSheets::DataService.fetch_sheet_data(token)
      end
    end
  end
end
