require 'google/apis/sheets_v4'

module GoogleSheets
  class ReportsService 
    class << self 
      def fetch_sheet_data(token, count=10)
        # parse yaml spreadsheet values into ruby array of arrays [['school', 'id'],...]
        school_spreadsheets = YAML.load(ENV['GOOGLE_SPREADSHEET_IDS'])

        # instantiate SheetsService with authorization token
        service = Google::Apis::SheetsV4::SheetsService.new()
        service.authorization = token 
        
        begin
          school_spreadsheets.map do |school_name, spreadsheet_id|
            OpenStruct.new({
              school: school_name,
              values: service.get_spreadsheet_values("#{spreadsheet_id}", "A1:G#{count + 1}").values
            })
          end 
        rescue => e
          {
            error: e.message
          }
        end
      end
    end
  end
end 
