module ObsRelationship
  extend ActiveSupport::Concern

  def observe_the_relationship
    after_create(self)
  end

  def after_create(relationship)
    RelationshipJob.set(wait: 5.seconds).perform_later(relationship)
  end

end