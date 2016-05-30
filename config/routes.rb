TechReviewSite::Application.routes.draw do

  get '/products/search' => 'products#search'
  resources :products, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end
  root 'products#index'

end
