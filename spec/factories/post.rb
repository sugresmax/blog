require 'ffaker'

FactoryBot.define do
  factory :post do
    title { FFaker::Book.title }
    body { FFaker::BaconIpsum.sentence }
    user_id { create(:user).id }
    published_at { FFaker::Time.datetime }
  end
end