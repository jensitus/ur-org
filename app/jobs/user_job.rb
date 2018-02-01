class UserJob < ApplicationJob
  queue_as :default

  def perform(user, what_user_action)
   if what_user_action == 'create'
     after_create(user)
   elsif what_user_action == 'update'
     # after_update(user)
   elsif what_user_action == 'destroy'
     after_destroy(user)
   end
  end

  private

  def after_create(user)
  UserMailer.registration_mail(user).deliver_now
  end

  def after_update(user)
    UserMailer.notice_when_invitation_accepted(user).deliver_now
  end

  def after_destroy(user)
    UserMailer.notice_when_user_destroyed(user).deliver_now
  end
end
