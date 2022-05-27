class Public::ReportsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    report = current_customer.reports.new(recipe_id: @recipe.id)
    report.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    report = current_customer.reports.find_by(recipe_id: @recipe.id)
    report.destroy
  end
end
