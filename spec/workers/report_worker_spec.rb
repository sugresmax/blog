require 'rails_helper'
require 'ffaker'

RSpec.describe ReportWorker, type: :worker do

  it 'sends jobs to sidekiq' do
    expect{
      ReportWorker.perform_async(Time.current.to_s, Time.current.to_s, FFaker::Internet.email)
    }.to change( ReportWorker.jobs, :size ).by(1)

  end

end
