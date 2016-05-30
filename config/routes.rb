TechReviewSite::Application.routes.draw do

  get '/products/search' => 'products#search'
  resources :products, only: [:index, :show]
  root 'products#index'

end
