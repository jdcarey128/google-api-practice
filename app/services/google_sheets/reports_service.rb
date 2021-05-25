require 'google/apis/sheets_v4'

module GoogleSheets
  class ReportsService 
    class << self 
      def fetch_sheet_data(token, count)
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

      def create_sheet(token, report)
        session = GoogleDrive::Session.from_access_token(token)

        # Creates the master spreadsheet
        spreadsheet = session.create_spreadsheet("Master report created: #{report.created_at}")
        worksheet = spreadsheet.worksheets[0]

        # inserts row values 
        headers = report.items.first.attributes.keys
        worksheet.insert_rows(1, [["Average Unit Price", report.average_price]])
        worksheet.insert_rows(3, [headers])

        report.items.each do |item|
          values = item.attributes.values
          # values need to be strings so size is defined 
          values = values.map(&:to_s)
          worksheet.insert_rows(worksheet.num_rows + 1, [values])
        end
        
        # commits inserted row changes
        worksheet.save
      end
    end
  end
end 
