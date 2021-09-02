Rails.application.routes.draw do
  get "question" => "question#top"
  get "question/newspot" => "question#newspot"
  get "question/:id" => "question#show"
  post "question/create" => "question#create"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
