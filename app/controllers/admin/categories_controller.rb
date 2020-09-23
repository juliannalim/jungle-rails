class Admin::CategoriesController < ApplicationController
  #need to restart database for this to work ( bin/rake db:reset )
  http_basic_authenticate_with name: ENV['ADMIN_AUTH_LOGIN'], password: ENV['ADMIN_AUTH_PASSWORD']

  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category= Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end
end

