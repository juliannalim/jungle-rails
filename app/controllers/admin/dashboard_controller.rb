class Admin::DashboardController < ApplicationController
  #need to restart database for this to work ( bin/rake db:reset )
  http_basic_authenticate_with name: ENV['ADMIN_AUTH_LOGIN'], password: ENV['ADMIN_AUTH_PASSWORD']

  def show
    @products_count = Product.count
    @categories_count = Category.count
  end
end
