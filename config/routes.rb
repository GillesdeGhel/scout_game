Rails.application.routes.draw do
  devise_for :users
  root to: 'home#show'
  resources :cities, only: [:index]
  resources :patrols, only: %i[show update]
  resources :attacks, only: %i[create index]
  resources :minings, only: %i[create index]
  resources :defenses, only: %i[create index]
  resources :buildings, only: %i[create index]
  resources :constructions, only: %i[create index]
  get 'end_turn', action: :end_turn, controller: 'turns'
end
