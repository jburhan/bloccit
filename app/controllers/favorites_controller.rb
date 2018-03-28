class FavoritesController < ApplicationController
  before_action :require_sign_in

  def create

    post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: post)

    if favorite.save
      flash[:notice] = "Successful!"
    else
      flash[:alert] = "Try again"
    end

    redirect_to [post.topic, post]
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

    if favorite.destroy
      flash[:notice] = "Not my thing."
    else
      flash[:alert] = "Failed!"
    end
      redirect_to [post.topic, post]
  end

end
