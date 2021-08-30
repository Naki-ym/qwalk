Rails.application.routes.draw do
  get "question" => "question#top"
  get "question/new" => "question#new"
  get "question/newspot" => "question#newspot"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
