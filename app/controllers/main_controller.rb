class MainController < ApplicationController
    def main
        session[:user_id] = nil
        @user = User.new
    end
    def login
        # puts "vvvvvvv"
        @user = User.find_by(email: login_params[:email])
        if @user != nil
            if @user.authenticate(login_params[:password])
                session[:user_id] = @user.id
                redirect_to "/feed"
            else
                redirect_to "/main", alert: "Wrong password"
            end
        else
            redirect_to "/main", alert: "Incorrect email"
        end
    end
    def register
        @user = User.new
    end
    def create_user
        @user = User.new(user_params.except(:confirm_password))
        if [@user.valid?,@user.check_password(user_params[:confirm_password])].all?
            @user.save
            Follow.create(followee_id: @user.id, follower_id: @user.id)
            session[:user_id] = @user.id
            redirect_to "/feed"
        else
            render :register, status: :unprocessable_entity
        end
        # if @user.save
    end
    def feed
        if isLogin
            @user = User.find(session[:user_id])
            @posts = @user.get_feed_post
        # @posts = @user.feed_posts
        end
    end

    def profile
        if isLogin
            @user = User.find(session[:user_id])
            @user_profile = User.find_by(name: params[:name])
            @posts = @user_profile.user_posts
            @isFollow = @user.isFollow(@user_profile)
        end
    end
    private
        def user_params
            params.require(:user).permit(:email, :name, :password, :confirm_password)
        end
        def login_params
            params.require(:user).permit(:email, :password)
        end

        def isLogin
            if (session[:user_id])
                return true
            else
                redirect_to "/main", alert: "Please login"
                return false
            end 
        end
end
