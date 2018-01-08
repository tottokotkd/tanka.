module CommentsHelper
  def comments_new_or_edit_path
    if action_name == "new" || action_name == "create"
      post_comments_path(@comment.post_id)
    elsif action_name == "edit" || action_name == "update"
      post_comment_path(@comment.post_id, @comment.id)
    end
  end
  
  def post_or_patch
    if action_name == "new"
      :post
    elsif action_name == "edit"
      :patch
    end
  end
end
