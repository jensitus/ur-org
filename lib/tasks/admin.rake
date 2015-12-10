# encoding utf-8
namespace :admin do
  task :the_user => :environment do
    u = User.find 1
    u.update(admin: true)
  end
end