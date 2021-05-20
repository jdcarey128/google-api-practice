class ReportsController < ApplicationController
  def index 
    @reports = Report.user_reports(current_user.id)
  end

  def show 
    @report = Report.find(params[:id])
  end
end
