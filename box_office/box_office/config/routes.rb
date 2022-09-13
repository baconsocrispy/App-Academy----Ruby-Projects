Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :films, only: [ :index, :show, :create, :update, :destroy, :new, :edit ]
  resources :films do 
    resources :distributed_territories, only: [ :create, :index, :show ]
  end
  
end
