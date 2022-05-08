class Public::FavoritesController < ApplicationController
  def create
    @recipe=Recipe.find(params[:recipe_id])
    favorite=current_customer.favorites.new(recipe_id:@recipe.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    @recipe=Recipe.find(params[:recipe_id])
    favorite=current_user.favorites.find_by(recipe_id:@re.id)
    favorite.destroy
    redirect_to request.referer
  end
end
