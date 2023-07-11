Rails.application.routes.draw do
  devise_for :users
  get 'wallet/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "wallet#index"
  get "wallet/show",to: "wallet#show",as:"show_balance"
  get "transaction_histories/send_money",to: "transaction_histories#send_money",as:"send_money"
  post "transaction_histories/send_money",to: "transaction_histories#create",as:"new_transaction"
  get "transaction_histories/verify",to: "transaction_histories#verify"
  get "transaction_histories/request_money",to: "transaction_histories#request_money",as:"request_money"
  post "transaction_histories/request_money",to: "transaction_histories#give",as:"new_give"
  get "transaction_histories/show_requests",to: "transaction_histories#show_requests",as:"show_request"
  get "transaction_histories/show_requests/cancel",to: "transaction_histories#cancel",as:"cancel"
  get "transaction_histories/show_requests/edit",to:"transaction_histories#edit",as:"edit"
  post"transaction_histories/show_requests/edit",to: "transaction_histories#update",as: "update"
  get "transaction_histories/show_transactions",to:"transaction_histories#show_transactions",as:"show_transactions"
  get "transaction_histories/specific_transactions",to:"transaction_histories#specific_transactions"
  get "transaction_histories/search",to:"transaction_histories#search"
  get "loan/show",to:"loan#show",as:"show_loan"
  get "loan/new",to: "loan#new",as:"new_loan"
  post "loan/new",to:"loan#create",as:"create_loan"
  get "loan/:loan_id/emi/index",to:"emi#index",as:"emi_index"
  get "loan/index",to:"loan#index",as:"loan"
  post "loan/index",to:"loan#update",as:"update_loan"
  get "wallet/set_pin",to:"wallet#set_pin",as:"set_pin"
  post "wallet/set_pin",to:"wallet#update",as:"update_wallet"
end 
