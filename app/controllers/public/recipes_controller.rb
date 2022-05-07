class Public::RecipesController < ApplicationController
  def new
    @recipe=Recipe.new
    #build＝子モデルのnew
    @recipe_ingredients=@recipe.recipe_ingredients.build
    @steps=@recipe.steps.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe.id)
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
end
