class Publics::CommentsController < ApplicationController
	before_action :authenticate_user!
	
	def create
		user = User.find(params[:user_id])
		post = Post.find(params[:post_id])
	    comment = current_user.comments.new(comment_params)
	    comment.post_id = post.id
	    comment.save
	    redirect_to  publics_user_post_path(user_id:user.id, id:post.id)
	end

	private
	def comment_params
	    params.require(:comment).permit(:user_id,:post_id,:comment_content)
	end
end
