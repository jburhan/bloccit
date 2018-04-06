module UsersHelper
  def user_posts_if_any(posts)
    if posts.any?
      render @user.posts
    else
      "#{current_user.name} has not submitted any posts yet."
    end
  end

  def user_comments_if_any(comments)
    if comments.any?
      render @user.comments
    else
      "#{current_user.name} has not submitted any comments yet."
    end
  end
end
