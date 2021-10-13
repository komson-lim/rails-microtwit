class User < ApplicationRecord
    has_many :posts
    has_many :followee_members, class_name: "Follow", foreign_key: "follower_id"
    has_many :follower_members, class_name: "Follow", foreign_key: "followee_id"
    has_many :followers, through: "follower_members"
    has_many :followees, through: "followee_members"
    has_secure_password
    validates :email,:name, uniqueness: true 
    validates :email,:name,:password, presence: true

    def followee_posts
        self.followees.joins(:posts).select("message", "name", "posts.created_at AS created_at").order("created_at DESC")
    end
    def user_posts
        self.posts.joins(:user).select("message", "name", "posts.created_at AS created_at").order("created_at DESC")
    end
    # def feed_posts
    #     self.followee_posts + self.user_posts
    # end
    def isFollow(user)
        Follow.find_by(follower_id: self.id, followee_id: user.id)
    end
    def isCorrectUser
        self.id == session[:user_id]
    end
    def check_password(password)
        if (self.password == password)
            return true
        else
            errors.add(:password, "doesn't match")
            return false
        end
    end

end
