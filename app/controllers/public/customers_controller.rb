class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: %i[edit favorites my_forums withdraw]

  def show
    @customer = Customer.find(params[:id])
    @recipes = Recipe.where(customer_id: @customer.id).page(params[:page])
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(current_customer.id), notice: '登録情報を更新しました。'
    else
      render 'edit'
    end
  end

  # 会員のお気に入りレシピ表示
  def favorites
    @customer = current_customer
    favorites = Favorite.where(customer_id: @customer.id).pluck(:recipe_id)
    @favorite_recipes = Kaminari.paginate_array(Recipe.find(favorites)).page(params[:page])
  end

  # 会員が掲示板に投稿したトピックと注目アクションをしたトピック表示
  def my_forums
    @customer = current_customer
    attentions = Attention.where(customer_id: @customer.id).pluck(:forum_id)
    @forums = if params[:my_forum]
                Forum.where(customer_id: @customer.id).page(params[:page])
              elsif params[:attention]
                Kaminari.paginate_array(Forum.find(attentions)).page(params[:page])
              else
                Forum.where(customer_id: @customer.id).page(params[:page])
              end
  end

  def withdraw
    customer = current_customer
    # is_deletedカラムをtrueに変更して削除フラグを立てる
    customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: 'アカウントを削除しました。'
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :customer_image, :encrypted_password, :is_deleted)
  end

  def ensure_guest_customer
    @customer = current_customer
    redirect_to root_path, notice: 'ゲストユーザーはその機能を使用できません。' if @customer.name == 'ゲストユーザー'
  end
end
