class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search
  protect_from_forgery with: :exception

  def search
    @search = Recipe.ransack(params[:q])
    # 結果は重複させない
    @result = @search.result.distinct
    # レシピを新着順に並べる
    if params[:latest]
      @recipes = @result.latest.page(params[:page])
    # レシピをいいねが多い順に並べる
    elsif params[:favorite]
      @recipes = Kaminari.paginate_array(@result.recipe_favorites).page(params[:page])
    # レシピを１週間でいいねが多い順に並べる
    elsif params[:week_favorite]
      @recipes = Kaminari.paginate_array(@result.recipe_week_favorites).page(params[:page])
    else
      @recipes = @result.page(params[:page])
    end
  end

   protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
