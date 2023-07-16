Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, shallow: true
  end
  post '/answers/:id', to: 'answers#mark_as_best', as: 'mark_as_best'
  root to:"questions#index"
end