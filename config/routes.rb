Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  scope :contacts do
    get '/' => 'contacts#index', as: :contacts
    post 'manage_csv' => 'contacst#manage_csv', as: :contacts_manage_csv
  end
end
