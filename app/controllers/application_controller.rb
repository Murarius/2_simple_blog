# class ApplicationController < ActionController::Base
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sidebar_to_cookie(sidebar)
    cookies[:sidebar] = sidebar.to_json
  end

  def sidebar_mark_to_cookie
    cookies[:sidebar_mark] = AppConfig.sidebar_mark
  end

  def create_new_sidebar
    sidebar = Sidebar.new
    sidebar_to_cookie(sidebar)
    sidebar_mark_to_cookie
    sidebar
  end

  def load_sidebar
    return create_new_sidebar unless cookies[:sidebar] && AppConfig.valid_sidebar_mark?(cookies[:sidebar_mark])
    Sidebar.new_from_cookie(cookies[:sidebar])
  end
end
