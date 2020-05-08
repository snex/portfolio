Rails.application.routes.draw do
  resources :holidays
  resources :quotes
  resources :transactions
  resources :financial_assets

  root 'index#index'
end
