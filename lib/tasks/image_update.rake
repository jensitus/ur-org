# namespace :update do
#   desc 'move the images from micropost to photo'
#   task :images => :environment do
#     m = Micropost.find 11
#     puts m.picture
#     Photo.create(micropost_id: m.id, picture: m.picture)
#   end
# end