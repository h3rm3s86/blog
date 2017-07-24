Rails.application.routes.draw do
  api_version(:module => "V2", :path => {:value => "v2"}) do
    #get 'v2/articles/show'
    get 'articles/test'
    get 'articles/index'
    post 'articles/update'

    #resources :articles do
    #  resources :comments
    #end

    #root 'welcome#index'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'welcome/index'

  #get '/articles/test'
  get '/users/send_mail'
  get '/users/send_mail_sidekiq'
  #post '/users/send_mail'
  resources :articles do
    resources :comments
  end

  root 'welcome#index'
end
