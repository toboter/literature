Rails.application.routes.draw do
  get 'home/index'

  resources :subjects
  resources :monographs, controller: 'subjects', type: 'Monograph'
  resources :in_books, controller: 'subjects', type: 'InBook'
  resources :collections, controller: 'subjects', type: 'Collection'
  resources :in_collections, controller: 'subjects', type: 'InCollection'
  resources :proceedings, controller: 'subjects', type: 'Proceeding'
  resources :in_proceedings, controller: 'subjects', type: 'InProceeding'
  resources :journals, controller: 'subjects', type: 'Journal'
  resources :issues, controller: 'subjects', type: 'Issue'
  resources :in_journals, controller: 'subjects', type: 'InJournal'
  resources :references, controller: 'subjects', type: 'Reference'
  resources :in_references, controller: 'subjects', type: 'InReference'
  resources :miscs, controller: 'subjects', type: 'Misc'
  resources :serials, controller: 'subjects', type: 'Serial'
  
  root 'home#index'
end
