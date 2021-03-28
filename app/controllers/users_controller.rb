require 'json'
require 'open-uri'

class UsersController < ApplicationController
    def index
        url = "https://randomuser.me/api/"
        user_serialized = open(url).read
        @user = JSON.parse(user_serialized)
    end

    def show
        if params[:number]
            url = "https://randomuser.me/api/?results=#{params[:number]}"
            user_serialized = open(url).read
            @users = JSON.parse(user_serialized)
        end
    end
    
    def create
        @user = User.new(user_params)
    
        if @user.save
          redirect_to @user
        else
          render :new
        end
      end

    private
      def user_params
        params.require(:user).permit(:title, :first_name, :last_name, :address, :phone, :email)
      end
end
