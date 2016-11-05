Rails.application.routes.draw do

  resources :users do
    post 'create'
  end

  resources :forums do
    get 'index'
    get 'show'
    post 'create'
    patch 'update'
  end

end
