class User < ApplicationRecord
    has_many :posts
    has_many :followee_members, class_name: "Follow", foreign_key: "follower_id"
    has_many :follower_members, class_name: "Follow", foreign_key: "followee_id"
    has_many :followers, through: "follower_members"
    has_many :followees, through: "followee_members"
    has_secure_password
end
