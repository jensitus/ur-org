class RelationshipObserver < ActiveRecord::Observer
  def after_create(user)
    RelationshipMailer.relationship_mail(user).deliver
    #user('jens@ist-ur.org', 'new dings', user).deliver
  end
end
