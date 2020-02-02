class Publics::FavoritesController < ApplicationController
		before_action :authenticate_user!
        
        def create
                post = Post.find(params[:post_id])
                @user = post.user
                favorite = current_user.favorites.new(post_id: post.id)
                favorite.save
                redirect_to publics_user_post_path(@user, post)
        end

        def destroy
                post = Post.find(params[:post_id])
                @user = post.user
                favorite = current_user.favorites.find_by(post_id: post.id)
                favorite.destroy
                redirect_to publics_user_post_path(@user, post)
        end
end
