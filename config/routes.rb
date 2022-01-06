Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'tokenbox_store/index'
  get 'tokenbox_store/redirect'
  root "subscriptions#new"
  post "my_own_process_token", to: "subscriptions#create"
  post "token_create", to: "tokenbox_store#create"
end
