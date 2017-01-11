require "sinatra"
require "sinatra/reloader"
require "pry"
require "active_record"
require "sinatra/activerecord"
require "pg"

require_relative "./models/user"
require_relative "./models/inventory"
require_relative "./models/spool"
require_relative "./models/shopping_list"
require_relative "./models/project"

set :database_file, "./config/database.yml"
set :sessions, true

helpers do
    def logged_in?
        !!current_user
    end

    def current_user
        User.find_by(id: session[:user_id])
    end
end


get "/" do
  if logged_in?
    redirect to("/inventory")
  else redirect to("/entrypage")
  end
end

get "/entrypage" do
  if logged_in?
    redirect to("/inventory")
  end
  erb :loginpage
end


post "/signup" do
  begin
    @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect to("/inventory")
    elsif User.exists?(:username => params[:username])
      redirect to("/")
    elsif params[:username] == "" || params[:password] == ""
      redirect to("/")
    end

  rescue
    "Generic error message"

  end

end

post "/login" do
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to("/inventory")
  else
    redirect to("/")
  end
end

get "/inventory" do
  Inventory.destroy(current_user.inventories.where("amount <= ?", 0).ids)
  @inventory = Inventory.where(user_id: session[:user_id]).order(:spools_id)
  erb :inventory
end

post "/inventory" do
  if params[:spools_id] == nil
    redirect to("/inventory")
  end
  amount = (params[:whole].to_f + (params[:point].to_f / 8)) * params[:operator].to_f
  if current_user.add_spool(Spool.find(params[:spools_id]), amount)
    redirect to("/inventory")
  else
    redirect to("/inventory?error=true")
  end
end


post "/deletethread/:id" do
  Inventory.destroy(current_user.inventories.where(spools_id: params["id"]))
  redirect to("/inventory")
end

get "/shoppinglist" do
  ShoppingList.destroy(current_user.shopping_lists.where("amount <= ?", 0).ids)
  @list = ShoppingList.where(user_id: session[:user_id]).order(:spools_id)
  erb :shoppinglist
end

post "/shoppinglist" do
  if params[:spools_id] == nil
    redirect to("/shoppinglist")
  end
  current_user.add_to_shopping(Spool.find(params[:spools_id]), params[:amount])
  redirect to ("/shoppinglist")
end


delete "/session" do
  session[:user_id] = nil
  redirect to("/")
end

get "/projects" do
  @projects = Project.where(user_id: session[:user_id])
  erb :project
end

post "/newproject" do
  current_user.new_project(params[:spools_ids], params[:projectname])
  @new = Project.find_by(user_id: session[:user_id], name: params[:projectname])
  redirect to("/project/#{@new.id}/confirm")
end

get "/project/*/confirm" do
  @project = Project.find_by(user_id: session[:user_id], id: params[:splat])
  erb :projectconfirm
end



post "/buythread/:id" do
  @item = ShoppingList.find_by(user_id: session[:user_id], spools_id: params[:id])
  @item.buy_spool
  redirect to("/shoppinglist")

end

post "/deleteitem/:id" do
  ShoppingList.destroy(current_user.shopping_lists.where(spools_id: params["id"]))
  redirect to("/shoppinglist")
end

post "/buyall" do
  ShoppingList.where(user_id: session[:user_id]).each do |item|
    item.buy_spool
  end
  redirect to("/inventory")
end

post "/pushtosl" do
  @keys = params.keys
  c = 0
  params.each do |i|
    @spool = Spool.find(@keys[c])
    @amount = params[@keys[c]]
    current_user.add_to_shopping(@spool, @amount)
    c += 1
  end
  redirect to("/shoppinglist")
end

get "/close/:id" do
  begin
    @project = Project.find_by(user_id: session[:user_id], id: params[:id])
    erb :projectclose
  # rescue
  #   binding.pry
  #   pass
  end
end

post "/closeproject" do
  @project = Project.find_by(user_id: session[:user_id], id: params[:projectid])
  @keyarr = Array.new
  params.keys.each do |i|
    @keyarr.push(i.split)
  end
  c = 0
  @keyarr.each do |k|
    if k.length == 2 && c % 2 != 0
      @inventory = Inventory.find_by(user_id: session[:user_id], id: k[0])
      @inventory.update_amount(params.values[c].to_f + (params.values[(c + 1)].to_f / 8))
    end
    c += 1
  end
  Project.destroy(@project)
  current_user.save
  redirect to("/projects")
end

not_found do
  erb :notfound
end
