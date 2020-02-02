Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'publics/users#index'
	get '/top' => 'publics/top#top'
	  
	  
	get 'publics/users/:id/follower' => 'publics/users#follower', as: 'follower'
	get 'publics/users/:id/followed' => 'publics/users#followed', as: 'followed'
	post 'publics/follow/:id' => 'publics/relationships#follow', as: 'follow' # フォローする
	post 'publics/unfollow/:id' => 'publics/relationships#unfollow', as: 'unfollow' # フォロー外す
  
  
  
	namespace :publics do
		resources :users do
			resources :posts do
	        	resource :favorites, only: [:create, :destroy]
	        	resource :comments, only: [:create, :destroy]
	    	end
	    end
	    resources :rooms, :only => [:create, :show, :index]
	    resources :messages, :only => [:create]
	    resource :favorites, only: [:create, :destroy]
	    resources :notifications, only: :index
	  end

  	get 'publics/posts' => 'publics/posts#index2'
  
end
