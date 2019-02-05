require 'ffaker'

FactoryBot.define do
  factory :user do
    nickname { FFaker::Name.first_name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/shaman.jpg'), 'image/jpeg') }
  end
end