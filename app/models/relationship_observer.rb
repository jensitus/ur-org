class RelationshipObserver < ActiveRecord::Observer
  def after_create(user)
    cd RelationshipMailer.relationship_mail(user).deliver
  end
end
