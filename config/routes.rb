Rails.application.routes.draw do
  root 'users#index'
  get "users/create" => "users#index"
  get "users" => "users#index"
  get "users/:id" => "users#show"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  post "users/:id/update" => "users#update"
  post "users/:id/destroy" => "users#destroy"
  
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  
  get "mypage" => "question#mypage"

  get "play" => "play_quest#play"
  get "play/correct" => "play_quest#correct_answer"
  get "clear" => "play_quest#quest_clear"
  post "play/answer-check" => "play_quest#answer_check"
  
  get "question" => "question#top"
  get "question/create" => "question#new"
  get "question/:id" => "question#show"
  get "question/:id/newspot" => "spots#new"
  get "question/:id/edit" => "question#edit"
  post "question/create" => "question#create"
  post "question/:id/update" => "question#update"
  post "question/:id/destroy" => "question#destroy"
  post "question/:id/publish" => "question#publish"
  post "question/:id/unpublish" => "question#unpublish"
  post "question/:id/play" => "play_quest#challenge"
  post "question/:id/play/destroy" => "play_quest#destroy"

  get "spots/:id" => "spots#show"
  get "spots/:id/edit" => "spots#edit"
  post "spots/create" => "spots#create"
  post "spots/:id/update" => "spots#update"
  post "spots/:id/destroy" => "spots#destroy"

  namespace 'api' do
    namespace 'v1' do
      resources :users
    end
  end
end
