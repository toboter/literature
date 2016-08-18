Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', as: 'signout'

  resources :subjects
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
  
  root 'home#index'
end
