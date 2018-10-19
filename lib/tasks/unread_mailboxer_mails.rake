# encoding utf-8
namespace :mailbox do
  task :get_unread_messages => :environment do
    g = Group.all
    g.each do |group|
      ur = ReadPost.where(read: false, group_id: group.id)
      ur.each do |p|
        u = User.find(p.user_id)
        puts u.inspect
      end
    end
  end
end