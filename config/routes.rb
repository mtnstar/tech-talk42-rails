Rails.application.routes.draw do
  resources :peaks
  root "peaks#index"
end
