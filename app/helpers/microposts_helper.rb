module MicropostsHelper
  def mention_link(content)
    content.gsub /@(\w+)/ do |username|
      link_to(username, single_user_path(username.gsub('@', '')))
    end.html_safe
  end
end
