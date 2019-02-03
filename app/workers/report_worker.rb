class ReportWorker
  include Sidekiq::Worker

  def perform(start_date, end_date, email)
    ReportMailer.send_report(start_date, end_date, email).deliver_now
  end

end
