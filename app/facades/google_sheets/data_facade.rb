module GoogleSheets
  class DataFacade 
    class << self 
      def fetch_sheet_data(token, count=10)
        GoogleSheets::DataService.fetch_sheet_data(token, count)
      end
    end
  end
end
