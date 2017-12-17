module ObsRelationship
  extend ActiveSupport::Concern

  def observe_the_relationship
    after_create(self)
  end

  def after_create(relationship)
    RelationshipMailer.relationship_mail(relationship).deliver_later
  end

end