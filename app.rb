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

get "/shoppinglist" do
  @list = ShoppingList.where(user_id: session[:user_id]).order(:spools_id)
  erb :shoppinglist
end

post "/shoppinglist" do
  current_user.add_to_shopping(Spool.find(params[:spools_id]), params[:amount])
  redirect to ("/shoppinglist")
end


delete "/session" do
  session[:user_id] = nil
  redirect to("/")
end

get "/projects" do
  erb :project
end

post "/newproject" do
  current_user.new_project(params[:spools_ids], params[:projectname])
  redirect to("/projects")
end

not_found do
  erb :notfound
end
