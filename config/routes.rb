Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: {omniauth_callbacks: 'oauth_callbacks'}

  namespace :users do
    resource :oauth_email_confirmations, only: %i[new create]
  end

  concern :votable do
    member do
      put :vote_plus
      put :vote_minus
      delete :cancel
    end
  end

  concern :commentable do
    resource :comments, only: :create
  end

  resources :questions, concerns: [:votable, :commentable] do
    resources :answers, concerns: [:votable, :commentable], shallow: true do
    end
  end
  post '/answers/:id', to: 'answers#mark_as_best', as: 'mark_as_best'
  delete '/answers/:id/files/:file_id', to: 'answers#delete_file', as: 'answer_delete_file'
  delete '/questions/:id/files/:file_id', to: 'questions#delete_file', as: 'question_delete_file'
  get '/users/:id/rewards', to: 'users#rewards', as: 'user_rewards'
  root to:"questions#index"

  mount ActionCable.server => '/cable'

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [] do
        get :me, on: :collection
      end

      resources :questions, only: [:index]
    end
  end
end