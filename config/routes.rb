Rails.application.routes.draw do
  get '' => 'users#new'
  
  get '/main' => 'users#new', as: 'users_new'
  post '/users/create' => 'users#create', as: 'users_create'
  get '/users/:user_id/edit' => 'users#edit', as: 'users_edit'
  patch '/users/:user_id/update' => 'users#update', as: 'users_update'
  get '/users/:user_id' => 'users#show', as: 'users_show'

  post '/sessions/create' => 'sessions#create', as: 'sessions_create'
  delete '/sessions/destroy' => 'sessions#destroy', as: 'sessions_destroy'

  get '/groups' => 'groups#index', as: "groups_index"
  post '/groups/create' => 'groups#create', as: "groups_create"
  delete '/groups/:group_id/destroy' => 'groups#destroy', as: "groups_destroy"
  patch '/groups/:group_id/join' => 'groups#join', as: "groups_join"
  patch '/groups/:group_id/leave' => 'groups#leave', as: "groups_leave"
  get '/groups/:group_id' => 'groups#show', as: "groups_show"
end
