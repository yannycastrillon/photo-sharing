Rails.application.routes.draw do
  root "photos#index"
  get "/slideshows/showslide", to: "slideshows#showslide"
  resources :photos
  resources :categories
  resources :slideshows

end
