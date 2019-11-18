Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'companies/:company_id/shipments', to: 'shipments#index'
end
