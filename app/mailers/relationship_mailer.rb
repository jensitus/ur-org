class RelationshipMailer < ActionMailer::Base
  default from: 'info@service-b.org'

  def relationship_mail(user)
    @user = user
    mail(:to => @user.followed.email, subject: @user.follower.name + ' connected you')
  end

end
