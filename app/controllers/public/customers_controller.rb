class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(current_customer.id) ,notice: "登録情報を更新しました"
    else
      render "edit"
    end
  end

  def favorites
  end

  def unsubscribe
  end

  def withdraw
    customer = current_customer
    #is_deletedカラムをtrueに変更して削除フラグを立てる
    customer.update(is_deleted: true)
    reset_session
    redirect_to root_path ,notice: "アカウントを削除しました"
  end

  private

  def customer_params
    params.require(:customer).permit(:name,:email,:customer_image,:encrypted_password,:is_deleted)
  end

end
