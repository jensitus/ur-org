class RelationshipObserver < ActiveRecord::Observer
  def after_create(user)
    RelationshipMailer.relationship_mail(user).deliver_later
  end
end
