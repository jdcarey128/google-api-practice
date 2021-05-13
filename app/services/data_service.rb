require 'google/apis/sheets_v4'

class DataService 
  class << self 
    def get_data(token)
      spreadsheet_id = ENV['GOOGLE_SPREADSHEET_ID']

      service = Google::Apis::SheetsV4::SheetsService.new()
      service.authorization = token 
      begin
        response = service.get_spreadsheet_values("#{spreadsheet_id}", "A1:G5")
      rescue => e
        require 'pry'; binding.pry
      end

    end
  end
end
