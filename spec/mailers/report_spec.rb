require "rails_helper"
require 'ffaker'

RSpec.describe ReportMailer, type: :mailer do

  describe 'send report' do

    let(:email){ FFaker::Internet.email }
    let(:mail) { described_class.send_report(Time.current.to_s, Time.current.to_s, email).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Report')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([email])
    end

  end

end
