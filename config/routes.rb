Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'static#home'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout' },
             controllers: { passwords: 'users/passwords', sessions: 'users/sessions' }
  resources :posts, except: :index
  resources :comments, only: [:create, :destroy]
  get 'posts_by/:year', to: 'posts_by#year_posts_months_counts'
end
