require "sinatra"
require "sinatra/reloader"
require "pry"
require "active_record"
require "sinatra/activerecord"
require "pg"

require_relative "./models/user"
require_relative "./models/inventory"


set :database_file, "./config/database.yml"
set :sessions, true


get "/" do
  #check if active session, otherwise
  redirect to("/signup")
end

get "/signup" do
  erb :loginpage
end

get "/login" do
  erb :loginpage
end

post "/signup" do
  begin
    @user = User.new(@params)
    if @user.save
      session[:user_id] = @user.id
      redirect to("/inventory")
    end
  rescue
    "Generic error message"

  end

end

post "/login" do
  users = User.all
  user = users.find_by username: (@params[:username])
  if user != nil
    if user[:password] == @params[:password]
      binding.pry
      session[:user_id] = user[:id]
      redirect to("/inventory")
    end
  end
end

get "/inventory" do
  binding.pry
  @inventory = Inventory.where(user_id: session[:user_id])
  erb :inventory
end

post "/inventory" do
  @thread = Inventory.new(@params)
  @thread.required = false
  @thread.in_use = false
  @thread.user_id = session[:user_id]
  @thread.save
  redirect to("/inventory")
end
