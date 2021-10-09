class User < ApplicationRecord
    has_many :posts
    has_many :followee_members, class_name: "Follow", foreign_key: "follower_id"
    has_many :follower_members, class_name: "Follow", foreign_key: "followee_id"
    has_many :followers, through: "follower_members"
    has_many :followees, through: "followee_members"
    has_secure_password
    def self.followee_posts(user)
        user.followees.joins(:posts).select("message", "name", "posts.created_at AS created_at").order("created_at DESC")
    end
end
