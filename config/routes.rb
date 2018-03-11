Rails.application.routes.draw do
  resources :questions
  resources :advertisements


  resources :topics do
    # resources:posts pass the resources :topics. this rests the post routes under the topic routes
     resources :posts, except: [:index]
     resources :sponsored_posts
   end

   #only hash key will prevent rails from creating other routes than new and create
   resources :users, only: [:new, :create]

  get 'about' => 'welcome#about'

  get 'contact' => 'welcome#contact'

  get 'faq' => 'welcome#faq'

  root 'welcome#index'
end
