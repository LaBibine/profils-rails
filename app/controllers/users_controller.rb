require 'json'
require 'open-uri'

class UsersController < ApplicationController
  skip_forgery_protection
  
    def index
        url = "https://randomuser.me/api/"
        user_serialized = open(url).read
        @user = JSON.parse(user_serialized)
    end

    def show
        if params[:number]
            @number = params[:number]
            url = "https://randomuser.me/api/?results=#{params[:number]}"
            user_serialized = open(url).read
            @users = JSON.parse(user_serialized)
        end
        if params[:users]
          @users = params[:users]
        end
    end

    def create
        @users = params[:users]

        @user = User.new({ :title => params[:title], :first_name => params[:first_name],  :last_name => params[:last_name], :address => params[:address], :phone => params[:phone], :email => params[:email]})

        if @user.save
          redirect_to action: "show", users: JSON.encode(@users)
        else
          render :new
        end

    end

    private
      def user_params
        params.require(:user).permit(:title, :first_name, :last_name, :address, :phone, :email)
      end
end
