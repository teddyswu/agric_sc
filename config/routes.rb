Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  resources :agris do
    get "comic",:on => :collection
    post "comic_create", :on => :collection
    get "gif",:on => :collection
    get "movie", :on => :collection
    post "movie_create", :on => :collection
    get "article", :on => :collection
    post "article_create", :on => :collection

  end
  get "agris/comic_del/:id", :to => "agris#comic_del", :as => "comic_del"
  delete "agris/gif_del/:id", :to => "agris#gif_del", :as => "gif_del"
  get "agris/movie_del/:id", :to => "agris#movie_del", :as => "movie_del"
  root :to => "agris#index"
  resources :upload_tools
  resources :stories
  resources :user_manages
  resources :data_connects do
    get "story", :on => :collection
  end
end
