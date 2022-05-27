class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id), notice: '登録情報を更新しました。'
    else
      render 'edit'
    end
  end

  def customer_recipes
    @customer = Customer.find(params[:id])
    @recipes = if params[:latest]
                 @customer.recipes.order(created_at: 'DESC').page(params[:page])
               elsif params[:report]
                 Kaminari.paginate_array(@customer.recipes.recipe_reports).page(params[:page])
               else
                 @customer.recipes.where(customer_id: @customer.id).page(params[:page])
               end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :customer_image, :encrypted_password, :is_deleted)
  end
end
