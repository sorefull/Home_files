Rails.application.routes.draw do

  get 'admins', to: 'admins#index', as: 'admins_index'
  get 'show/:id', to: 'admins#show', as: 'admins_show'
   get 'change/:id', to: 'admins#change', as: 'admins_change'
   get 'set_welcome/:id',  to: 'admins#set_to_about_welcome', as: 'set_welcome'
   get 'delete_about', to: 'admins#delete_adout', as: 'delete_adout'

  root 'welcome#index'
  get 'about', to: 'welcome#about', as: 'welcome_about'

  devise_for :users

  resources :posts, only: [:index, :new, :create, :destroy, :show]
  get 'about_posts', to: 'posts#about', as: 'about_posts'

  resources :folders, only: [:index, :new, :create, :destroy, :show] do
    resources :contents, except: [:index, :edit, :update, :show]
    get 'set_public/:id(.:format)', to: 'contents#public!', as: 'set_public'
  end
  get 'about_folders', to: 'folders#about', as: 'about_folders'

  get 'public', to: 'folders#public', as: 'public_folder'
  get 'about_public', to: 'folders#about_public', as: 'about_public_folders'

  # only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'post_comments/:post_id', to: 'admins#post_comments', as: 'admins_post_comments'
end
