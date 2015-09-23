class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def create
    report = current_user.reports.build(report_params)
    report.save
    render nothing: true, status: 200, content_type: 'text/html'
  end

  private

    def report_params
      params.require(:report).permit(:reportable_type, :reportable_id)
    end
end
