class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!, only: [:new]
  before_action :ensure_customer, only: [:edit, :update, :destroy]
  before_action :ensure_guest_customer, only: [:new]

  def new
    @recipe = Recipe.new
    @ingredient = @recipe.ingredients.build
    @step = @recipe.steps.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    if @recipe.save
      redirect_to recipe_path(@recipe.id), notice: 'レシピを投稿しました。'
    else
      render 'new'
    end
  end

  def index
    @recipes = if params[:latest]
                # レシピを新着順に並べる
                 Recipe.latest.page(params[:page])
               elsif params[:favorite]
                # レシピをいいねが多い順に並べる
                 Kaminari.paginate_array(Recipe.recipe_favorites).page(params[:page])
               elsif params[:week_favorite]
                # レシピを１週間でいいねが多い順に並べる
                 Kaminari.paginate_array(Recipe.recipe_week_favorites).page(params[:page])
               else
                 Recipe.page(params[:page])
               end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients
    @steps = @recipe.steps
    @comment = Comment.new
    @comments = @recipe.comments.order(created_at: 'DESC').page(params[:page]).per(5)
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe.id), notice: 'レシピを更新しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to customer_path(current_customer.id), notice: 'レシピを削除しました。'
  end

  def search_tag
    @tag = Tag.find(params[:tag_id])
    @recipes = if params[:latest]
                # レシピを新着順に並べる
                 @tag.recipes.latest.page(params[:page])
               elsif params[:favorite]
                # レシピをいいねが多い順に並べる
                 Kaminari.paginate_array(@tag.recipes.recipe_favorites).page(params[:page])
               elsif params[:week_favorite]
                # レシピを１週間でいいねが多い順に並べる
                 Kaminari.paginate_array(@tag.recipes.recipe_week_favorites).page(params[:page])
               else
                 @tag.recipes.page(params[:page])
               end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :serving, :description, :recipe_image, tag_ids: [], steps_attributes: %i[id step_description _destroy],
                                                                                  ingredients_attributes: %i[id quantity _destroy content])
  end

  def ensure_guest_customer
    @customer = current_customer
    redirect_to root_path, notice: 'ゲストユーザーはその機能を使用できません。' if @customer.name == 'ゲストユーザー'
  end

  def ensure_customer
    @recipe = Recipe.find(params[:id])
    unless @recipe.customer == current_customer
      redirect_to recipes_path, notice: 'その機能は使用できません。'
    end
  end
end
