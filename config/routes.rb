Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    resources :discover, only: :index
    # resources :movies, only: [:show, :index] do
    #   resources :viewing_parties, only: [:new, :show]
    end
  end
end

            #                       Prefix Verb URI Pattern                                                                                       Controller#Action
            #                         root GET  /                                                                                                 welcome#index
            #                register_user GET  /register(.:format)                                                                               users#new
            #          user_discover_index GET  /users/:user_id/discover(.:format)                                                                discover#index
            # new_user_movie_viewing_party GET  /users/:user_id/movies/:movie_id/viewing_parties/new(.:format)                                    viewing_parties#new
            #     user_movie_viewing_party GET  /users/:user_id/movies/:movie_id/viewing_parties/:id(.:format)                                    viewing_parties#show
            #                  user_movies GET  /users/:user_id/movies(.:format)                                                                  movies#index
            #                   user_movie GET  /users/:user_id/movies/:id(.:format)                                                              movies#show
            #                        users POST /users(.:format)                                                                                  users#create
            #                         user GET  /users/:id(.:format)                                                                              users#show
