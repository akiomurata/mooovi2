TechReviewSite::Application.routes.draw do

  resources :products, only: :index
  root 'products#index'

end
