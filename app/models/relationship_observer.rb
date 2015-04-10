class RelationshipObserver < ActiveRecord::Observer
  def after_create(user)
    RelationshipMailer.delay.relationship_mail(user)
  end
end
