Fitafy::Application.routes.draw do
  
  get "reverse_bookings/index"
  
  resources :user_sessions, only: [:new, :create, :destroy] 
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:index, :create, :update, :destroy]
  resources :clients, only: [:new, :create, :edit, :update]
  
  resources :bookings do
    resources :exercises, controller: 'bookings/exercises', only: [:index, :create, :update, :destroy]
  end
  
  resources :exercises do
    resources :workouts, controller: 'exercises/workouts', only: :index
  end 
  
  resources :workouts do
    resources :bookings, controller: 'workouts/bookings', only: :index
  end
  
  resources :users do
    resources :reverse_bookings, only: :index
    member do
      get :training, :trained_by
    end
  end
  
  match 'signin', to: "user_sessions#new"
  match 'signup', to: "users#new"
  match 'signout', to: "user_sessions#destroy"
  match 'invites', to: "relationships#index"
  root to: 'pages#home'

end
