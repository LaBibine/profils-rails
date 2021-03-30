require 'json'
require 'open-uri'
require 'csv'

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
        session[:users] = JSON.parse(user_serialized)
        @users =session[:users]
      end
      if session[:users]
        @users = session[:users]
      end
    end

    def create
        @users = session[:users]

        @user = User.new({ :title => params[:title], :first_name => params[:first_name],  :last_name => params[:last_name], :address => params[:address], :phone => params[:phone], :email => params[:email]})
       
        if @user.save
          redirect_to "/users/show"
        else
          render :new
        end

    end

    def data
      @users = User.all
    end

    def export
      @users = User.all
      unless File.exist?("data.csv")
        File.new("data.csv", "w+") 
      end
      file = "#{Rails.root}/data.csv"
      headers = ["ID", "Title", "First_Name", "Last_Name", "Address", "Phone", "Email"]
      CSV.open(file, 'w', write_headers: true, headers: headers) do |writer| 
          @users.each do |data|
              writer << [data.id, data.title, data.first_name, data.last_name, data.address, data.phone, data.email]
          end
      end
    redirect_to action: "data", isexported: true
    end

    private
      def user_params
        params.require(:user).permit(:title, :first_name, :last_name, :address, :phone, :email)
      end

end
