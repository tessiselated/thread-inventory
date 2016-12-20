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

binding.pry
