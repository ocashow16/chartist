Rails.application.routes.draw do
  root 'top#index'
  get 'charts' => 'charts#index'
end
