Rails.application.routes.draw do
  resources :workspaces
  namespace :v1 do
    post 'user_token' => 'user_token#create'

    resources :artists do
      resources :events, only: %i[index]
      resources :workspaces, only: %i[index]
    end
    resources :expense_categories do
      resources :expenses
    end
    resources :events do
      resources :artists, only: %i[index show]
      resources :venue, only: %i[show]
      resources :workspaces, only: %i[index]
    end
    resources :users do
      resources :workspaces, only: %i[index]
    end
    resources :venues do
      resources :events, only: %i[index]
      resources :workspaces, only: %i[index]
    end
    resources :workspaces do
      resources :artists, only: %i[index]
      resources :events, only: %i[index]
      resources :users, only: %i[index]
      resources :venues, only: %i[index]
    end
  end
end
