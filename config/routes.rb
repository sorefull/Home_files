Rails.application.routes.draw do

  get 'admins', to: 'admins#index', as: 'admins_index'
  get 'show/:username', to: 'admins#show', as: 'admins_show'
  get 'change/:username', to: 'admins#change', as: 'admins_change'
  get 'set_welcome/:title',  to: 'admins#set_to_about_welcome', as: 'set_welcome'
  get 'about/delete', to: 'admins#delete_about', as: 'delete_about'

  root 'welcome#index'

  devise_for :users

  resources :posts, only: [:index, :new, :create, :destroy]
  get 'post/:title', to: 'posts#show', as: 'post_show'

  resources :folders, only: [:index, :new, :create, :destroy] 
  get '/folders/:title', to: 'folders#show', as: 'folder_show'
  get '/folders/:title/set_public/:id(.:format)', to: 'contents#public!', as: 'set_public'

  get '/folders/:title/new', to: 'contents#new', as: 'new_folder_content'
  post '/folders/:title', to: 'contents#create', as: 'folder_contents'
  delete '/folders/:title/:id', to: 'contents#destroy', as: 'folder_content'
    get 'public', to: 'folders#public', as: 'public_folder'
  # public storrage of files

  get 'about', to: 'welcome#about', as: 'welcome_about'
  get 'about_posts', to: 'posts#about', as: 'about_posts'
  get 'about_public', to: 'folders#about_public', as: 'about_public_folders'
  get 'about_folders', to: 'folders#about', as: 'about_folders'
  # info pages with instructions

  # only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'post_comments/:post_id', to: 'admins#post_comments', as: 'admins_post_comments'
end
