require_relative 'cookbook'
require_relative 'recipe'
require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook = Cookbook.new(csv_file)

get '/' do
  @recipe_list = cookbook.all
  erb :index

end

get '/new' do
  erb :new
end

post '/new_recipe' do
  recipe = Recipe.new(params[:name], params[:description], params[:rating], params[:prep_time])
  cookbook.add_recipe(recipe)
  @recipe_list = cookbook.all
  erb :index
end

get '/destroy/:index' do
  # index = cookbook.all.index(params[:name])
  p params
  cookbook.remove_recipe(params[:index].to_i)
  @recipe_list = cookbook.all
  erb :index
end

# get '/destroy/:name' do
#   index = cookbook.all.index(params[:name])
#   cookbook.remove_recipe(index)
#   erb :index
# end