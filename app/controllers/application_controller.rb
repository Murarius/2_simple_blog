class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sidebar_to_cookie(sidebar)
    cookies[:sidebar] = render_to_string(template: 'sidebar/sidebar.json.jbuilder', locals: { sidebar: sidebar })
  end

  def load_sidebar
    if cookies[:sidebar]
      sidebar_cookie = JSON.parse(cookies[:sidebar], symbolize_names: true)[:sidebar]
      sidebar = Sidebar.new(sidebar_cookie[:new_posts], sidebar_cookie[:posts_counts_by_years])
    else
      sidebar = Sidebar.new
      sidebar_to_cookie(sidebar)
    end
    sidebar
  end
end
