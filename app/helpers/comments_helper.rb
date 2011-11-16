module CommentsHelper
  def user_link(user)
    if user.nil?
      content_tag :td,"Unknown"
    else
      content_tag :td do
        link_to user.name, user_path(user)
      end   
    end
  end

end
