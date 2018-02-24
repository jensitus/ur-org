# encoding utf-8
namespace :custom do
  task :appearance => :environment do
    users = User.all
    users.each do |user|
      if CustomAppearance.find_by_user_id(user.id).nil?
        c = CustomAppearance.create(user_id: user.id)
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        puts c.inspect
        puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        sleep 0.7
      end
    end
  end
end