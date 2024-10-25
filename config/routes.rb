Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "words#index"
  resources :words
  resources :words_bulk_uploads, only: %i[new create]
end
