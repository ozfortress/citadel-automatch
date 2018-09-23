Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :auto_match do
        get 'find', to: '#find'
        post 'register', to: '#register'
        post 'update', to: '#update'
        post 'submit', to: '#submit'
      end
    end
  end

  get 'matches/:id/auto_match/verify', controller: 'auto_match', action: :show, as: 'auto_match_verify'
  post 'matches/:id/auto_match/verify', controller: 'auto_match', action: :update
end
