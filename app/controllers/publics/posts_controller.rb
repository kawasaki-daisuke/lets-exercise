class Publics::PostsController < ApplicationController
	before_action :authenticate_user!

	def new
		@post = Post.new
	end

	def create
		post = Post.new(post_params)
		post.user_id = current_user.id
		post.save
		redirect_to publics_user_posts_path
	end

	def index
		@user = User.find(params[:user_id])
		@posts = Post.where(user_id:@user.id)
		@posts = @posts.page(params[:page]).per(10)
	end

	def show
		@post = Post.find(params[:id])
		@user = User.find(params[:user_id])
		@comment = Comment.new
		@comments = @post.comments
		@comments = @comments.page(params[:page]).per(10)
	end

	def index2
		@posts = Post.search(params[:search])
		@posts = @posts.page(params[:page]).per(10)
	end

	def destroy
		@user = User.find(params[:user_id])
	    @post = Post.find(params[:id])
	    if  @post.destroy
	    	redirect_to publics_user_posts_path(@user)
	    else
        	render :index
        end
  	end

	private
		def post_params
			params.require(:post).permit(:user_id, :post_image, :post_content)
		end
end
