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

end
