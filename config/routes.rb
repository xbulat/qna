Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'questions#index'

  concern :votes do
    member do
      post :like
      post :dislike
      delete :revoke
    end
  end

  resources :questions, shallow: true, concerns: [:votes] do
    resources :answers, except: [ :show, :new ], concerns: [:votes] do
      patch :best, on: :member
    end
  end

  resources :links, only: :destroy
  resources :attachments, only: :destroy
  resources :badges, only: :index
end
