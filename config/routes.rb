Rails.application.routes.draw do

  root 'welcome#index'
  get 'about', to: 'welcome#about', as: 'welcome_about'

  devise_for :users

  resources :posts, only: [:index, :new, :create, :destroy, :show]
  get 'about_posts', to: 'posts#about', as: 'about_posts'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'post_comments/:post_id', to: 'admins#post_comments', as: 'admins_post_comments'
end
