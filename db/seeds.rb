
require "YAML"
require_relative "../models/spool"


seed_file = "./db/seeds/dmc.yml"
config = YAML::load_file(seed_file)

Spool.destroy_all

config.each do |row|
  s = Spool.new
  s.dmc = row["dmc"]
  s.name = row["name"]
  s.rgb = row["rgb"]
  s.save
end
