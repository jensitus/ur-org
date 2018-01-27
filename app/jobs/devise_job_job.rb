class DeviseJobJob < ApplicationJob
  queue_as :default

  def perform(notification, obj, args)
    puts '# Do something later'
    puts notification
    puts args
    puts obj
    # devise_mailer.send(notification, self, *args).deliver_later
  end
end
