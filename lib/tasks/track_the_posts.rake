namespace :track do
  task :posts => :environment do
    trackable_id_array = []
    pg_result = ActiveRecord::Base.connection.execute("select trackable_id from activities where trackable_type = 'Micropost'")
    pg_result.each do |track_id|
      puts track_id
      trackable_id_array << track_id['trackable_id']

    end
    trackable_id_array = trackable_id_array.uniq
    puts trackable_id_array

    Micropost.all.each do |micropost|
      puts trackable_id_array.include?(micropost.id.to_s)
      puts micropost.id
      user = micropost.user
      puts user.name
      if !trackable_id_array.include?(micropost.id.to_s)
        activity = micropost.create_activity :create, owner: user
        activity.update(created_at: micropost.created_at)
      end
      puts activity.inspect
      sleep 1
    end

  end
end