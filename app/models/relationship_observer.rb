class RelationshipObserver < ActiveRecord::Observer
  def after_create(user)
    RelationshipMailer.relationship_mail(user).deliver
  end
end
