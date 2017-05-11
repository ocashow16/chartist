Rails.application.routes.draw do
  root 'top#index'
  get 'top/new' => 'top#new'
  post'top'     => 'top#create'
end
