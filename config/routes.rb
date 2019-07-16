Rails.application.routes.draw do
  resources :data_connects do
    match "story", :on => :collection, via: [:get, :post]
    match ":v/story", :to => "data_connects#story", :constraints => {:v => /[A-Za-z0-9\.]+?/}, :on => :collection, via: [:get, :post]
  end
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks", sessions: 'users/sessions'}
  resources :users do
    get "profile", on: :collection
    get "fb_binding", on: :collection
  end
  
  get "agris/comic_del/:id", :to => "agris#comic_del", :as => "comic_del"
  delete "agris/gif_del/:id", :to => "agris#gif_del", :as => "gif_del"
  get "agris/gif_edit/:id", :to => "agris#gif_edit", :as => "gif_edit"
  get "agris/movie_del/:id", :to => "agris#movie_del", :as => "movie_del"
  get "showgif/:id", :to => "agris#showgif", :as =>"show_gif"
  get "showjpg/:id", :to => "agris#showjpg", :as =>"show_jpg"
  get "showpng/:id", :to => "agris#showpng", :as =>"show_png"
  
  get "agris/wording_list", :to => "agris#wording_list", :as => "wording_list"
  
  get "agris/wording_json/:id", :to => "agris#wording_json", :as => "wording_json"
  get "agris/wording_set_list/:id", :to => "agris#wording_set_list", :as => "wording_set_list"
  get "agris/wording_set_new/:id", :to => "agris#wording_set_new", :as => "wording_set_new"
  get "agris/wording_set_edit/:id", :to => "agris#wording_set_edit", :as => "wording_set_edit"
  patch "agris/wording_set_update/:id", :to => "agris#wording_set_update", :as => "wording_set_update"
  post "agris/wording_set_create", :to => "agris#wording_set_create", :as => "wording_set_create"
  delete "agris/wording_set_delete/:id", :to => "agris#wording_set_delete", :as => "wording_set_delete"
  get "agris/wording_new", :to => "agris#wording_new", :as => "wording_new"
  post "agris/wording_create", :to => "agris#wording_create", :as => "wording_create"
  patch "agris/wording_update/:id", :to => "agris#wording_update", :as => "wording_update"
  get "agris/wording_edit/:id", :to => "agris#wording_edit", :as => "wording_edit"
  delete "agris/wording_delete/:id", :to => "agris#wording_delete", :as => "wording_delete"
  
  resources :user_inputs
  resources :farmers do 
    get "work_record", on: :member
    post "favo_farmers", :on => :collection
  end
  get "farmers/:id/mobile_img/:record_id", :to => "farmers#mobile_img", :as => "farmer_mobile_img"
  get "farmers/:id/page/:page", :to => "farmers#page", :as => "farmer_page"

  resources :multi_image_uploads

  resources :message_pushes

  resources :parameter_sets do
    get "list", on: :member
    get "set_list", on: :member
    get "set_new", on: :member
    get "set_edit", on: :member
    post "set_create", on: :collection
    patch "set_update", on: :member
    delete "set_delete", on: :member
  end

  resources :personal_interplays

  resources :reply_words

  resources :user_groups

  resources :ps_groups

  resources :wordings
  resources :wording_cats

  resources :work_walls
  get "work_walls/page/:page", :to => "work_walls#page", :as => "work_wall_page"

  resources :agris do
    get "comic",:on => :collection
    post "comic_create", :on => :collection
    get "gif",:on => :collection
    get "movie", :on => :collection
    post "movie_create", :on => :collection
    get "article", :on => :collection
    get "user_list", :on => :collection
    get "user_list_alert", :on => :collection
    post "user_list_search", :on => :collection
    post "article_create", :on => :collection
  end
  resources :upload_tools
  resources :user_profiles
  resources :stories do
    get "list", :on => :collection
  end
  root to: 'root#index'
  resources :work_records do 
    get "outputs", :on => :collection
    get "mood", :on => :collection
    get "record_img", :on => :member
    get "rate", :on => :member
    get "join_projects", :on => :collection
    get "interactive_admin_index", :on => :collection
    post "interactive_admin_create", :on => :collection
    get "interactive_admin_edit", :on => :member
    get "interactive_admin_new", :on => :collection
    patch "interactive_admin_update", :on => :member
    delete "interactive_admin_delete", :on => :member
    get "interactive_admin_edit", :on => :member
    get "interactive_show", :on => :member
    get "interactive", :on => :collection
  end
  get "work_records/interactive_show/:id", :to => "work_records#interactive_show", :as => "interactive_show"
  resources :work_projects
  resources :work_diaries do
    get "record_img", :on => :member
  end
  resources :farming_categories do
    get "binding", :on => :collection
    post "create_binding", :on => :collection
  end
  resources :user_manages do
    get "farmer", :on => :collection
  end
  resources :work_record_replies
end
