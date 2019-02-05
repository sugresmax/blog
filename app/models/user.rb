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
    sql = Arel.sql(
        "SELECT users.id, users.nickname, users.email,
      (SELECT COUNT(*) FROM posts where users.id = posts.user_id) AS posts_count,
      (SELECT COUNT(*) FROM comments where users.id = comments.user_id) AS comments_count,
      ((SELECT COUNT(*) FROM posts where users.id = posts.user_id) + (SELECT COUNT(*) FROM comments where users.id = comments.user_id) / 10.0) AS weight
      from users
      LEFT OUTER JOIN comments ON comments.user_id = users.id
      LEFT OUTER JOIN posts ON posts.user_id = users.id
      where (comments.published_at > '#{start_date}') AND (comments.published_at < '#{end_date}')
      OR (posts.published_at > '#{start_date}') AND (posts.published_at < '#{end_date}')
      group by users.id
      order by weight desc"
    )
    ActiveRecord::Base.connection.exec_query(sql).to_hash
  end

  private

  def password_digest_errors_to_password
    errors[:password_digest].each{ |e| errors.add(:password, e) } if errors[:password_digest]
  end

end
