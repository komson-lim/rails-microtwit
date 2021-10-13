class FollowController < ApplicationController
    def create
        follower = params[:follower_id]
        followee = params[:followee_id]
        @user = User.find(follower)
        if isCorrectUser && (follower != followee)
            Follow.create(follower_id: follower, followee_id: followee)
            redirect_to "/profile/#{User.find(followee).name}"
        end
    end
    def destroy
        follower = params[:follower_id]
        followee = params[:followee_id]
        @user = User.find(follower)
        if isCorrectUser
            Follow.destroy(Follow.find_by(follower_id: follower, followee_id: followee).id)
            redirect_to "/profile/#{User.find(followee).name}"
        end
    end
    private
        def isCorrectUser
            if (@user && (@user.id == session[:user_id]))
                return true
            else
                redirect_to "/main", alert: "Access denied"
                return false
            end 
        end 
end
