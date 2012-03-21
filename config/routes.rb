Fitafy::Application.routes.draw do
  
  resources :user_sessions, only: [:new, :create, :destroy] 
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:index, :create, :update, :destroy]
  resources :reverse_relationships, only: [:create, :destroy], controller: "reverse_relationships"
  resources :clients, only: [:index, :new, :create, :edit, :update]
  resources :booking_requests, controller: 'bookings/requests'

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
    resources :reverse_bookings, controller: 'users/reverse_bookings', only: :index
    resources :completed_reverse_bookings, controller: 'users/completed_reverse_bookings', only: :index
    member do
      get :training, :trained_by
    end
  end
  
  match 'signin', to: "user_sessions#new"
  match 'signup', to: "users#new"
  match 'signout', to: "user_sessions#destroy"
  match 'invites', to: "relationships#index"
  match 'booking_invites', to: "bookings/requests#index"
  root to: 'pages#home'

  mount Resque::Server, at: "/resque"
end