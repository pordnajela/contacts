Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  scope :contacts do
    get '/' => 'contacts#index', as: :contacts
    get '/list' => 'contacts#list', as: :list_contacts
    post 'manage_csv' => 'contacts#manage_csv', as: :contacts_manage_csv
  end
end
