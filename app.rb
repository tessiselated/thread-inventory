require "sinatra"
require "sinatra/reloader"
require "pry"
require "active_record"
require "sinatra/activerecord"
require "pg"

require_relative "./models/user"
require_relative "./models/inventory"
require_relative "./models/spool"


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
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to("/inventory")
  end
end

get "/inventory" do
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

delete "/session" do
  session[:user_id] = nil
  redirect to "/"
end
