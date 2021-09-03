Rails.application.routes.draw do
  root 'users#index'
  get "users" => "users#userlist"
  get "users/:id" => "users#show"
  
  get "question" => "question#top"
  get "question/create" => "question#top"
  get "question/:id" => "question#show"
  get "question/:id/newspot" => "question#newspot"
  get "question/:id/edit" => "question#edit"
  post "question/create" => "question#create"
  post "question/:id/update" => "question#update"
  post "question/:id/destroy" => "question#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
