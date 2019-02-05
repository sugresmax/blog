require 'rails_helper'
require 'ffaker'

RSpec.describe Api::V1::Reports::ByAuthorsController, type: :controller do

  describe 'POST #create' do

    let(:email){ FFaker::Internet.email }

    before do
      process :create, method: :post,
              params: { start_date: '01.01.2019', end_date: '31.12.2019', email: email, format: :json }
    end

    it 'responds with success status' do
      expect(response).to have_http_status(:success)
    end

    it 'returns json with message key' do
      result = JSON.parse(response.body)
      expect(result).to have_key('message')
    end

    it 'calls ReportWorker.perform_async method' do
      allow(ReportWorker).to receive(:perform_async).
          with(start_date: '01.01.2019', end_date: '31.12.2019', email: email)
    end

  end

end