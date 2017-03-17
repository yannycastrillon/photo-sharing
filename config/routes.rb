Rails.application.routes.draw do
  root "photos#index"
  get "/slideshows/show_slide", to: "slideshows#show_slide"
  patch "/slideshows/update_slide_order", to: "slideshows#update_slide_order"

  resources :photos
  resources :categories
  resources :slideshows

end
