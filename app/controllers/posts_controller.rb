class PostsController < ApplicationController
  #this call the require_sign_in action, except for show.
  before_action :require_sign_in, except: :show
  before_action :moderator, except: [:show, :new, :create, :destroy]
  before_action :authorize_user, except: [:show, :new, :create, :edit, :update]

  def index
    @posts.each_with_index do |post,index|
      if (index + 1) % 5 == 0
        post.title = "SPAM"
      end
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @topic = Topic.find(params[:topic_id])
    @post.topic = @topic
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error. Try again."
      render :new
    end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "An error occured, please try again."
      render :edit
    end

  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "Error occured while deleting the post."
      render :show
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def moderator
    post = Post.find(params[:id])

    unless current_user == post.user || current_user.admin? || current_user.moderator?
      flash[:alert] = "You must be authorized to do that."
      redirect_to [post.topic, post]
    end
  end

  def authorize_user
    post = Post.find(params[:id])

    unless current_user == post.user || current_user.admin?
      flash[:alert] = "You must be authorized to do that."
      redirect_to [post.topic, post]
    end
  end

end
