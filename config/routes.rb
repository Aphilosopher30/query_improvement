Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/ask', to: 'request#ask'
  get '/input', to: 'request#input'

end
