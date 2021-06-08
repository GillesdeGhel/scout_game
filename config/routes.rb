Rails.application.routes.draw do
  devise_for :users
  root to: 'home#show'
  resources :cities, only: [:index]
  resources :patrols, only: %i[show index update]
  resources :attacks, only: %i[create index destroy]
  resources :minings, only: %i[create index destroy]
  resources :defenses, only: %i[create index destroy]
  resources :buildings, only: %i[create index]
  resources :constructions, only: %i[create index destroy]
  get 'end_turn', action: :end_turn, controller: 'turns'
end
