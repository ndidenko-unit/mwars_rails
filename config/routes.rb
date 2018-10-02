Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :players, :battles
  # get "players" => "players#index"
  # get "players/new" => "players#new"
  root controller: :players, action: :index

end
