Rails.application.routes.draw do
  resources :readings, only: [:create, :show] do
    member do 
      get :stats
    end
  end
end
