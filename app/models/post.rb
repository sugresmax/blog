class Post < ApplicationRecord

  has_many :comments
  belongs_to :user

  validates :title, :body, presence: true

  before_create :set_published_at

  private

  def set_published_at
    self.published_at = Time.current if published_at.nil?
  end

end
