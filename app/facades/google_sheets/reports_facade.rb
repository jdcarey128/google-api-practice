module GoogleSheets
  class ReportsFacade
    class << self 
      def fetch_sheet_data(token, count=10, user_id)
        response = GoogleSheets::ReportsService.fetch_sheet_data(token, count)
        # returns array of item ids 
        item_ids = Item.items_from_sheets(response)
        # returns created report 
        # links report to Items through Report Items 
        Report.generate_report(user_id, item_ids)
      end
    end
  end
end
