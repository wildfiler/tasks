Tasks::Application.routes.draw do

  devise_for :users, path: 'auth'
  resources :users
  resources :comments

  get 'tasks/project/:project_id' => 'tasks#index_by_project', as: 'project_tasks'
  get 'tasks/without_project' => 'tasks#index_wo_project', as: 'without_project_tasks'
  resources :tasks do
    namespace :status, module: 'tasks', controller: 'status' do
      post 'reopen'
      post 'start'
      post 'suspend'
      post 'finish'
    end
    resources :comments
  end

  resources :projects do
    post 'add_user'
    delete 'delete_user/:id', action: 'delete_user', as: 'delete_user'
    get 'new_task' => 'tasks#new'
    get 'tasks'
  end

  root 'welcome#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
