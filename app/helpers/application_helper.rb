module ApplicationHelper
  # Return 'active' class for current url
  #
  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end

  # Return full title
  #
  def full_title(page_title = '')
    base_title = "Ruby on Rails test application"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
