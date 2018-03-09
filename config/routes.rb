Rails.application.routes.draw do
  resources :questions
  resources :advertisements

  resources :topics do
    # resources:posts pass the resources :topics. this rests the post routes under the topic routes
     resources :posts, except: [:index]
   end

  get 'about' => 'welcome#about'

  get 'contact' => 'welcome#contact'

  get 'faq' => 'welcome#faq'

  root 'welcome#index'
end
