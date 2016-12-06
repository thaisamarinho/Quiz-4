Rails.application.routes.draw do

  get '/' => 'home#index', as: :home

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :auctions do
    resources :bids
    post '/auctions/auction_id/publish' => 'transitions#create_publish', as: :publish
    post '/auctions/auction_id/cancel' => 'transitions#create_cancel', as: :cancel
    post '/auctions/auction_id/met' => 'transitions#create_met', as: :met
    post '/auctions/auction_id/not_met' => 'transitions#create_not_met', as: :not_met
    post '/auctions/auction_id/win' => 'transitions#create_win', as: :win
    post '/auctions/auction_id/draft' => 'transitions#create_draft', as: :draft
  end

end
