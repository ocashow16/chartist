Rails.application.routes.draw do
  devise_for :views
  root 'top#index'
  get 'top/new' => 'top#new'
  post'top'     => 'top#create'
end
