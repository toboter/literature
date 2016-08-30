Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', as: 'signout'

  resources :subjects
  resources :subject_imports
  
  resources :monographs, controller: 'subjects', type: 'Monograph'
  resources :in_books, controller: 'subjects', type: 'InBook'
  resources :collections, controller: 'subjects', type: 'Collection'
  resources :in_collections, controller: 'subjects', type: 'InCollection'
  resources :proceedings, controller: 'subjects', type: 'Proceeding'
  resources :in_proceedings, controller: 'subjects', type: 'InProceeding'
  resources :issues, controller: 'subjects', type: 'Issue'
  resources :in_journals, controller: 'subjects', type: 'InJournal'
  resources :references, controller: 'subjects', type: 'Reference'
  resources :in_references, controller: 'subjects', type: 'InReference'
  resources :miscs, controller: 'subjects', type: 'Misc'


  namespace :api, defaults: {format: 'json'} do
    scope module: :v1 do
      resources :citations, only: [:index, :show]
    end
  end
  
  get '/api', to: 'home#api'
  get '/help', to: 'home#help'
  get '/search', to: 'home#search'
  root 'home#index'
end
