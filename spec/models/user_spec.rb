require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    subject{ build(:user) }
    it { should validate_presence_of(:nickname) }
    it { should validate_uniqueness_of(:nickname) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should have_secure_password }
  end

  describe '#report' do

    let!(:users){ 3.times.map{create(:user)} }
    let!(:posts){ 10.times.map{ create(:post, user_id: users.sample.id, published_at: Time.current) } }
    let!(:comments){
      10.times.map{ create(:comment, user_id: users.sample.id, post_id: posts.sample.id, published_at: Time.current) }
    }

    let!(:inactive_user){ create(:user) }

    before do
      @result = User.report (Time.current - 1.month).to_s, (Time.current + 1.month).to_s
    end

    it 'returns array of hashes with needed attributes' do
      result = @result.sample
      expect(result).to have_key('nickname')
      expect(result).to have_key('email')
      expect(result).to have_key('posts_count')
      expect(result).to have_key('comments_count')
    end

  end

end
