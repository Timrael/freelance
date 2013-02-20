Freelance::Application.routes.draw do
  root :to => 'projects#index'

  devise_for :users

  resources :projects
end
