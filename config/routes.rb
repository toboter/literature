Rails.application.routes.draw do
  # added by nabu
  concern :commentable do
    resources :comments, only: [:index, :new, :create, :destroy]
  end
  # 'concerns: :commentable' needs to be added to any resource where nabu is included.

  resources :subjects
  resources :subject_imports
  
  resources :monographs, controller: 'subjects', type: 'Monograph', concerns: :commentable
  resources :in_books, controller: 'subjects', type: 'InBook', concerns: :commentable
  resources :collections, controller: 'subjects', type: 'Collection', concerns: :commentable
  resources :in_collections, controller: 'subjects', type: 'InCollection', concerns: :commentable
  resources :proceedings, controller: 'subjects', type: 'Proceeding', concerns: :commentable
  resources :in_proceedings, controller: 'subjects', type: 'InProceeding', concerns: :commentable
  resources :issues, controller: 'subjects', type: 'Issue', concerns: :commentable
  resources :in_journals, controller: 'subjects', type: 'InJournal', concerns: :commentable
  resources :references, controller: 'subjects', type: 'Reference', concerns: :commentable
  resources :in_references, controller: 'subjects', type: 'InReference', concerns: :commentable
  resources :miscs, controller: 'subjects', type: 'Misc', concerns: :commentable


  namespace :api, defaults: {format: 'json'} do
    scope module: :v1 do
      resources :citations, only: [:index, :show] do
        collection do
          get 'search'
        end 
      end
    end
  end

  scope :admin do
    resources :series, except: [:show, :new, :create]
    resources :creators, except: [:show, :new, :create]
  end

  get '/api', to: 'home#api'
  get '/help', to: 'home#help'

  root 'home#index'
end
