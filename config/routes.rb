Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  authenticate :user do
    scope :contacts do
      get '/' => 'contacts#index', as: :contacts
      get '/list' => 'contacts#list', as: :list_contacts
      get '/list_failed_contacts' => 'contacts#list_failed_contacts', as: :list_failed_contacts
      post 'manage_csv' => 'contacts#manage_csv', as: :contacts_manage_csv
    end

    scope :contact_files do
      get '/list' => 'contact_files#list', as: :list_contact_files
    end
  end
end
