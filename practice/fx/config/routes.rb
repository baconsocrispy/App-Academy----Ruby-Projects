Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :currencies, only: [ :create, :index, :destroy, :update, :edit, :new, :show ]
end
