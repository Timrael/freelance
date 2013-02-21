Freelance::Application.routes.draw do
  root :to => 'projects#index'

  devise_for :users

  resources :projects do
    resources :bids, :only => :create
    match "bids/:bid_id/choose" => "bids#choose", :via => :put
  end
end
