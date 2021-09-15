Rails.application.routes.draw do
  root 'users#index'
  get "users" => "users#userlist"
  get "users/:id" => "users#show"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  post "users/:id/update" => "users#update"
  post "users/:id/destroy" => "users#destroy"
  
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  
  get "mypage" => "question#mypage"
  
  get "question" => "question#top"
  get "question/create" => "question#top"
  get "question/:id" => "question#show"
  get "question/:id/newspot" => "spots#new"
  get "question/:id/edit" => "question#edit"
  post "question/create" => "question#create"
  post "question/:id/update" => "question#update"
  post "question/:id/destroy" => "question#destroy"

  get "spots/:id" => "spots#show"
  get "spots/:id/edit" => "spots#edit"
  post "spots/create" => "spots#create"
  post "spots/:id/update" => "spots#update"
  post "spots/:id/destroy" => "spots#destroy"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
