class RelationshipMailer < ApplicationMailer
  default from: 'info@ist-ur.org'

  def relationship_mail(user)
    @user = user
    mail(:to => @user.followed.email, subject: @user.follower.name + ' connected you')
  end

end
