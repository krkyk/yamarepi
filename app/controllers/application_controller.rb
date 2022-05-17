class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search
  protect_from_forgery with: :exception

  def search
    @search = Recipe.ransack(params[:q])
    # レシピを新着順に並べる
    if params[:latest]
      @recipes = @search.result.latest.page(params[:page])
    # レシピをいいねが多い順に並べる
    elsif params[:favorite]
      @recipes = Kaminari.paginate_array(@search.result.recipe_favorites).page(params[:page])
    # レシピを１週間でいいねが多い順に並べる
    elsif params[:week_favorite]
      @recipes = Kaminari.paginate_array(@search.result.recipe_week_favorites).page(params[:page])
    else
      @recipes = @search.result.page(params[:page])
    end
  end

   protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
