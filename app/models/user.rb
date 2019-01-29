class User < ApplicationRecord
  has_secure_password

  validates :nickname, :email, presence: true
  validates :password_digest, presence: true, on: :create

  after_validation :password_digest_errors_to_password

  private

  def password_digest_errors_to_password
    errors[:password_digest].each{ |e| errors.add(:password, e) } if errors[:password_digest]
  end

end
