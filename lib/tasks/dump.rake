# lib/tasks/dump.rake
namespace :db do
  desc "Dump the database"

  task :db_dump do
    system "pg_dump -Fc --no-owner --verbose --dbname=#{db_name} > #{dump_path}"
  end

  private

  def databaseconfig
    config = {}
    dbname = ENV["IST_UR_ORG_DEV_DB"]
    username = ENV["IST_UR_ORG_DEV_USR"]
    password = ENV["IST_UR_ORG_DEV_PW"]
    config.store('dbname', dbname)
    config.store('username', username)
    config.store('password', password)
    puts config['dbname']
    puts config['username']
    config
  end

  def db_name
    config = databaseconfig
    "postgresql://#{config['username']}:#{config['password']}@127.0.0.1:5432/#{config['dbname']}"
  end

  def dump_path
    Rails.root.join('db/dump/latest.dump').to_path
  end

end
