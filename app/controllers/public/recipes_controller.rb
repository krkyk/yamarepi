class Public::RecipesController < ApplicationController
  def new
    @recipe=Recipe.new
    #build＝子モデルのnew
    @recipe_ingredients=@recipe.recipe_ingredients.build
    @steps=@recipe.steps.build
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
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title,:serving,:description,steps_attributes:[:id,:step_description,:_destroy],recipe_ingredients_attributes:[:id,:quantity,:_destroy])
  end

end
