Classwork::Application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'schueler', to: 'students', as: 'schueler'
  
  resources :sessions

  resources :users

  resources :answer_students

  resources :tests do
    member do
      get 'state'
    end
  end

  resources :test_students

  resources :questions do
    resources :answers
  end

  resources :categories do
    resources :questions do
      resources :answers
    end
  end

  resources :students

  resources :courses

  resources :groups

  root :to => 'sessions#new'  
end
