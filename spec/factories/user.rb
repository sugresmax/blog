require 'ffaker'

FactoryBot.define do
  factory :user do
    nickname { FFaker::Name.first_name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end