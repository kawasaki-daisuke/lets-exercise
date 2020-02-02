class Publics::UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.search(params[:search]).page(params[:page])
		@users = @users.page(params[:page]).per(10)
	end

	def show
		@user = User.find(params[:id])
		@currentUserEntry=Entry.where(user_id: current_user.id)
	    @userEntry=Entry.where(user_id: @user.id)
	    if @user.id == current_user.id
	    else
	      @currentUserEntry.each do |cu|
	        @userEntry.each do |u|
	          if cu.room_id == u.room_id then
	            @isRoom = true
	            @roomId = cu.room_id
	          end
	        end
	      end
	      if @isRoom == true
	      else
	        @room = Room.new
	        @entry = Entry.new
	      end
	    end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		user = User.find(params[:id])
		user.update(user_params)
		redirect_to publics_user_path
	end

	def follower
		@user = User.find(params[:id])
		@users = @user.following_user
		@users = @users.page(params[:page]).per(10)
		render "follower"
	end

	def followed
		@user = User.find(params[:id])
		@users = @user.follower_user
		@users = @users.page(params[:page]).per(10)
		render "followed"
	end

	def destroy
		@user = User.find(params[:id])
	    if  @user.destroy
	    	redirect_to top_path
	    else
        	render :edit
        end
	end

	private
	def user_params
		params.require(:user).permit(:profile_image, :name, :tall, :weight, :gym, :email, :encrypted_password)
	end
end
