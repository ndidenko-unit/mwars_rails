Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :players

  resources :battles do
    member do
      get 'completed'
    end
  end
  # get "players" => "players#index"
  # get "players/new" => "players#new"
  root controller: :battles, action: :new

end
