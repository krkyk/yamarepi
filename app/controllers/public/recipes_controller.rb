class Public::RecipesController < ApplicationController

  def new
    @recipe=Recipe.new
    @ingredient=@recipe.ingredients.build
    @step=@recipe.steps.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id=current_customer.id
    if @recipe.save
      redirect_to recipe_path(@recipe.id) ,notice: "レシピを投稿しました"
    else
      render "new"
    end
  end

  def index
    @recipes=Recipe.page(params[:page])
  end

  def show
    @recipe=Recipe.find(params[:id])
    @ingredients=@recipe.ingredients
    @steps=@recipe.steps
    @comment=Comment.new
  end

  def edit
    @recipe=Recipe.find(params[:id])
  end

  def update
    @recipe=Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe.id), notice: "レシピを編集しました"
    else
      render "edit"
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to customer_path(current_customer.id)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title,:serving,:description,steps_attributes:[:id,:step_description,:_destroy],
    ingredients_attributes:[:id,:quantity,:_destroy,:content])
  end

end
