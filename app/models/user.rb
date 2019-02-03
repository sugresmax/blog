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

  def self.report(start_date, end_date)
    start_date = Time.parse start_date
    end_date = Time.parse end_date
    User.joins(:posts, :comments).
        select('users.id, nickname, email, posts_count, comments_count, (posts_count + comments_count / 10.0) AS weight').
        where('comments.published_at > ?', start_date).
        where('comments.published_at < ?', end_date).
        where('posts.published_at > ?', start_date).
        where('posts.published_at < ?', end_date).
        group('users.id').
        order('posts_count + comments_count / 10.0')
  end

  private

  def password_digest_errors_to_password
    errors[:password_digest].each{ |e| errors.add(:password, e) } if errors[:password_digest]
  end

end
