class User < ApplicationRecord
  has_secure_password

  has_many :posts
  has_many :comments

  validates :nickname, :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  after_validation :password_digest_errors_to_password

  private

  def password_digest_errors_to_password
    errors[:password_digest].each{ |e| errors.add(:password, e) } if errors[:password_digest]
  end

end
