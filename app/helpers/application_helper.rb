module ApplicationHelper
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    return base_title if @title.nil?
    return base_title + " | " + @title
  end
end
