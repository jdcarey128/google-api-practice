module GoogleSheets
  class DataFacade 
    class << self 
      def fetch_sheet_data(token, count=10)
        response = GoogleSheets::DataService.fetch_sheet_data(token, count)
        items = Item.items_from_sheets(response)
      end
    end
  end
end
