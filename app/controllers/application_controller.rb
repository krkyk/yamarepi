class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search
  protect_from_forgery with: :exception

  def search
    @search = Recipe.ransack(params[:q])
    # 結果は重複させない
    @result = @search.result.distinct
    @recipes = if params[:latest]
                # レシピを新着順に並べる
                 @result.latest.page(params[:page])
               elsif params[:favorite]
                # レシピをいいねが多い順に並べる
                 Kaminari.paginate_array(@result.recipe_favorites).page(params[:page])
               elsif params[:week_favorite]
                # レシピを１週間でいいねが多い順に並べる
                 Kaminari.paginate_array(@result.recipe_week_favorites).page(params[:page])
               else
                 @result.page(params[:page])
               end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
