# Preview all emails at http://localhost:3000/rails/mailers/report
class ReportPreview < ActionMailer::Preview

  def send_report
    ReportMailer.send_report('01.01.2019', '31.12.2019', 'foo@bar.baz')
  end
end
