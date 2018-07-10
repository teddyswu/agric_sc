Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks"}
  resources :users do
    get "profile", on: :collection
  end
  
  get "agris/comic_del/:id", :to => "agris#comic_del", :as => "comic_del"
  delete "agris/gif_del/:id", :to => "agris#gif_del", :as => "gif_del"
  get "agris/gif_edit/:id", :to => "agris#gif_edit", :as => "gif_edit"
  get "agris/movie_del/:id", :to => "agris#movie_del", :as => "movie_del"
  get "showgif/:id", :to => "agris#showgif", :as =>"show_gif"
  get "showjpg/:id", :to => "agris#showjpg", :as =>"show_jpg"
  
  get "agris/wording_list", :to => "agris#wording_list", :as => "wording_list"
  get "agris/wording_new", :to => "agris#wording_new", :as => "wording_new"
  post "agris/wording_create", :to => "agris#wording_create", :as => "wording_create"
  patch "agris/wording_update/:id", :to => "agris#wording_update", :as => "wording_update"
  get "agris/wording_edit/:id", :to => "agris#wording_edit", :as => "wording_edit"
  delete "agris/wording_delete/:id", :to => "agris#wording_delete", :as => "wording_delete"
  
  resources :farmers do 
    get "work_record", on: :member
  end

  resources :agris do
    get "comic",:on => :collection
    post "comic_create", :on => :collection
    get "gif",:on => :collection
    get "movie", :on => :collection
    post "movie_create", :on => :collection
    get "article", :on => :collection
    post "article_create", :on => :collection
  end
  resources :upload_tools
  resources :user_profiles
  resources :stories do
    get "list", :on => :collection
  end
  root :to => "stories#list"
  resources :work_records do 
    get "outputs", :on => :collection
    get "mood", :on => :collection
  end
  resources :work_projects
  resources :farming_categories do
    get "binding", :on => :collection
    post "create_binding", :on => :collection
  end
  resources :user_manages do
    get "farmer", :on => :collection
  end
  resources :work_record_replies
  resources :data_connects do
    match "story", :on => :collection, via: [:get, :post]
  end
end
