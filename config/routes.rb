Rails.application.routes.draw do
  root 'application#index'
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks", sessions: "users/sessions", passwords: "users/passwords", registrations: "users/registrations" }
  resources :headquarters, only: [:index]
  namespace :invoices_management do
    resources :countries, only: :index do
      resources :invoices do
          get :update_contacts, :on => :collection
          get :deletion_reason, :on => :collection
          get :send_mail, :on => :collection
          get :autocomplete_client_name, :on => :collection
      end
    end
  end
  resources :prospects do
      get :autocomplete_client_name, :on => :collection
      resources :estimations
      resources :quotations
  end
  resources :inventories do
    get :update_collaborators, on: :collection
    get :update_collaborators, on: :member
    get :update_operating_systems, on: :collection
    get :update_operating_systems, on: :member
  end
  resources :collaborators do
    resources :schedule#, only: [:index, :edit, :create, :update, :destroy]
    get :update_insurance_types, on: :collection
    get :update_insurance_types, on: :member
  end
  resources :countries
  resources :clients
  resources :contacts do
    get :autocomplete_client_name, :on => :collection
  end
  resources :datasets, only: [] do
    get :clients, on: :collection
  end
  resources :contacts_auxiliary, only: [] do
    get :contacts
  end
end