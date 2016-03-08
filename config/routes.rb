Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'static#home'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }

  resources :posts, except: :index
end
