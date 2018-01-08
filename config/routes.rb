Rails.application.routes.draw do
  resources :users, except:[:index, :destroy] do
    post :new_confirm, on: :collection
    patch :edit_confirm, on: :member
    resources :likes, only:[:index]
  end

  resources :sessions, only:[:new, :create, :destroy]
  
  resources :posts do
    post :new_confirm, on: :collection
    patch :edit_confirm, on: :member
    resources :comments, except:[:show]
  end

  post "likes/:post_id/create" => "likes#create"
  delete "likes/:post_id/destroy" => "likes#destroy"

  root :to => 'sessions#new'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
