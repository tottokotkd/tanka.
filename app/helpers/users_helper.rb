module UsersHelper
  def users_new_or_edit_confirm_path
    if action_name == "new" || action_name == "new_confirm"
      new_confirm_users_path
    elsif action_name == "edit" || action_name == "edit_confirm"
      edit_confirm_user_path(@user.id)
    end
  end
end
