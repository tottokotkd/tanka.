module PostsHelper
  def posts_new_or_edit_confirm_path
    if action_name == "new" || action_name == "new_confirm"
      new_confirm_posts_path
    elsif action_name == "edit" || action_name == "edit_confirm"
      edit_confirm_post_path(@post.id)
    end
  end
  
  def post_or_patch
    if action_name == "new" || action_name == "new_confirm"
      :post
    elsif action_name == "edit" || action_name == "edit_confirm"
      :patch
    end
  end
end
