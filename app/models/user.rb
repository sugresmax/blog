class User < ApplicationRecord
  has_secure_password

  has_many :posts
  has_many :comments

  mount_uploader :avatar, AvatarUploader

  validates :avatar, file_size: { less_than_or_equal_to: 3.megabytes },
            file_content_type: { allow: ['image/jpeg', 'image/png'] }

  validates :nickname, :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  after_validation :password_digest_errors_to_password

  private

  def password_digest_errors_to_password
    errors[:password_digest].each{ |e| errors.add(:password, e) } if errors[:password_digest]
  end

end
