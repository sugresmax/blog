require 'ffaker'

namespace :fake_data do

  desc 'Fill database with fake data'
  task fill: :environment do

    users = []
    5.times do
      user = {nickname: FFaker::Name.first_name,
              email: FFaker::Internet.email,
              password: FFaker::Internet.password }
      # User.create user
      users << user
    end

    User.create users

    User.find_each do |user|
      rand(5..20).times do
        Post.create(
                title: FFaker::Book.title,
                body: FFaker::BaconIpsum.sentence,
                user_id: user.id
        )
      end

      posts_count = Post.count
      rand(10..30).times do
        Comment.create(
                   body: FFaker::BaconIpsum.sentence,
                   user_id: user.id,
                   post_id: rand(1..posts_count)
        )
      end

    end

    pp users

  end

end

