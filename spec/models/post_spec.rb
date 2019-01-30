require 'rails_helper'

RSpec.describe Post, type: :model do

  describe 'validations' do
    subject{ build(:post) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe 'callbacks' do
    let(:post){ create(:post, published_at: nil) }

    it 'set published_at value if its empty' do
      expect(post.published_at).not_to be_nil
    end

  end

end
