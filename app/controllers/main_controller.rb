class MainController < ApplicationController
    def main
        session[:user_id] = nil
        @user = User.new
    end
    def login
        puts "vvvvvvv"
        @user = User.find_by(email: login_params[:email])
        if @user != nil
            if @user.authenticate(login_params[:password])
                redirect_to "/users"
            else
                redirect_to "/main", alert: "Wrong password"
            end
        else
            redirect_to "/main", alert: "Incorrect email"
        end
    end
    def feed
        @user = User.find(session[:user_id])
    end
    private
        def login_params
            params.require(:user).permit(:email, :password)
        end
end
