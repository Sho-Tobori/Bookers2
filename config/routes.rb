Rails.application.routes.draw do
  get 'reservations/create'
	get 'home/about' => 'users#about'
	root 'users#top'
	devise_for :users
  	resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
      resources :reservations
    end

  	resources :users, only: [:index, :show, :edit, :update]

    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :relationships, only: [:create, :destroy]
  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
