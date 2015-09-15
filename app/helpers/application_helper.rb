module ApplicationHelper

  def profile_link_or_deleted(user)
    user.present? ? (link_to user.name, user_path(user)) : "[deleted]"
  end
end
