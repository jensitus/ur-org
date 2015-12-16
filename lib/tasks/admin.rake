# encoding utf-8
namespace :admin do
  task :the_user do
    u = User.find 1
    #u.update(admin: true)
    puts 'donner wetter'
    puts u.inspect
  end
end