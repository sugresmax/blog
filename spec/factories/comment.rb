require 'ffaker'

FactoryBot.define do
  factory :comment do
    body { FFaker::BaconIpsum.sentence }
    user_id { create(:user).id }
    post_id { create(:post).id }
    published_at { FFaker::Time.datetime }
  end
end