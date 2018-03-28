Rails.application.routes.draw do
  resources :questions
  resources :advertisements


  resources :topics do
    # resources:posts pass the resources :topics. this rests the post routes under the topic routes
     resources :posts, except: [:index]
     resources :sponsored_posts
   end

# only: [] is used so we donot create any posts/:id routes
   resources :posts, only: [] do
     resources :favorites, only: [:create, :destroy]
     # we only add create and destroy routes
     resources :comments, only: [:create, :destroy]
     post '/up-vote' => 'votes#up_vote', as: :up_vote
     post '/down-vote' => 'votes#down_vote', as: :down_vote
   end
   #only hash key will prevent rails from creating other routes than new and create
  resources :users, only: [:new, :create]
    post 'users/confirmation' => 'users#confirmation'

  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  get 'contact' => 'welcome#contact'

  get 'faq' => 'welcome#faq'

  root 'welcome#index'
end
