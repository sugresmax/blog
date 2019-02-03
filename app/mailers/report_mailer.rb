class ReportMailer < ApplicationMailer

  def send_report(start_date, end_date, email)
    @users = User.report(start_date, end_date)
    mail(to: email, subject: 'Report')
  end

end
