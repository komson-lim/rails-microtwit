class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :like_users, through: :likes, foreign_key: "post_id"
  validates :message, presence: true
  def isLike(user)
    Like.exists?(user_id: user.id, post_id: self.id)
  end
end
