require 'render_anywhere'

class Download 
  include RenderAnywhere

  def initialize(report)
    @report = report 
  end

  def to_pdf
    kit = PDFKit.new(as_html)
    kit.to_file('tmp/report.pdf')
  end

  def filename
    "Report #{report.id}.pdf"
  end

  private 
  attr_reader :report 

  def as_html 
    render template: "reports/pdf",
           layout: 'report_pdf',
           locals: { report: report }
  end
end
