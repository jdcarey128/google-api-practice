module GoogleSheets
  class DownloadsController < ApplicationController
    def show
      respond_to do |format|
        format.pdf { send_report_pdf }
      end
    end

    private 

    def report 
      Report.find(params[:report_id])
    end

    def download
      Download.new(report)
    end

    def send_report_pdf
      # send file behavior in rails 
      send_file download.to_pdf, download_attributes
    end

    def download_attributes
      {
        filename: download.filename,
        type: 'application/pdf',
        disposition: 'inline'
      }
    end
    
  end
end 
