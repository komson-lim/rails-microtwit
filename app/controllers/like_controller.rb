class LikeController < ApplicationController
    def create
        post_id = params[:post_id]
        user_id = params[:user_id]
        @user = User.find(user_id)
        if isCorrectUser
            Like.create(post_id: post_id, user_id: user_id)
            redirect_to request.referer
        end
    end
    def destroy
        post_id = params[:post_id]
        user_id = params[:user_id]
        @user = User.find(user_id)
        if isCorrectUser
            Like.destroy(Like.find_by(post_id: post_id, user_id: user_id).id)
            redirect_to request.referer
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
