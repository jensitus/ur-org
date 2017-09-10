# encoding utf-8
namespace :photo do
  task :add_the_user_to_micropost_photos => :environment do
    m = Micropost.all
    m.each do |micropost|
      puts !micropost.photos.empty?
      if !micropost.photos.empty?
        micropost.photos.each do |p|
          puts p.inspect
          p.update(user_id: micropost.user.id)
          puts p.inspect
        end

      end
    end
  end

  task :add_the_user_to_gallery_photos => :environment do
    PhotoGallery.all.each do |pg|
      puts pg.inspect
      pg.photos.each do |photo|
        puts pg.users[0].id
        puts photo.inspect
        photo.update(user_id: pg.users[0].id)
        puts 'photo after update: ' + photo.inspect.to_s
      end
    end
  end
end