Rails.application.routes.draw do
  devise_for :users

  concern :votable do
    member do
      put :vote_plus
      put :vote_minus
      delete :cancel
    end
  end

  resources :questions, concerns: [:votable] do
    resources :answers, concerns: [:votable], shallow: true do
    end
  end
  post '/answers/:id', to: 'answers#mark_as_best', as: 'mark_as_best'
  delete '/answers/:id/files/:file_id', to: 'answers#delete_file', as: 'answer_delete_file'
  delete '/questions/:id/files/:file_id', to: 'questions#delete_file', as: 'question_delete_file'
  get '/users/:id/rewards', to: 'users#rewards', as: 'user_rewards'
  root to:"questions#index"
end