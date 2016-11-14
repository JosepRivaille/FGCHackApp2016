Rails.application.routes.draw do

  resources :users do

    post 'create'

  end

  resources :forums do

    get 'index'
    get 'show'
    post 'create'
    patch 'update'

    resources :entries do
      get 'index'
      post 'create'
    end

  end

end
