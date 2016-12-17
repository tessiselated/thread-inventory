require "sinatra"
require "sinatra/reloader"
require "pry"
require "active_record"
require "sinatra/activerecord"
require "pg"

require_relative "./models/user"


set :database_file, "./config/database.yml"


get "/" do
  #check if active session, otherwise
  redirect to("/login")
end

get "/login" do
  erb :loginpage
end
