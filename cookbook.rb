require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    load_csv
  end

  def all
    return @recipes
  end

  def add_recipe(new_recipe)
    @recipes << new_recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def done!(index)
    @recipes[index].mark = true
    save_csv
  end

  private

  def save_csv
    # save the new recipe in the CSV
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.mark, recipe.prep_time]
      end
    end
  end

  def load_csv
    # load recipes from csv
    CSV.foreach(@csv_file_path) do |row|
      mark = row[3] == "false" ? false : true
      @recipes << Recipe.new(row[0], row[1], row[2], mark, row[4])
    end
  end
end
