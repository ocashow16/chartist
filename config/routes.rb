Rails.application.routes.draw do
  root 'top#index'
  get 'top/new' => 'top#new'
end
