Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Applications
  resources :applications, param: :token, only: [:index, :show, :create, :update] do
    # Chats nested under applications
    resources :chats, param: :number, only: [:index, :create] do
      # Messages nested under chats
      resources :messages, only: [:index, :create] do
        collection do
          get :search
        end
      end
    end
  end
end