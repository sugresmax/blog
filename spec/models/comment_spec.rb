require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe 'validations' do
    subject{ build(:comment) }
    it { should validate_presence_of(:body) }
  end

end