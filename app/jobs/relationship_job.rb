class RelationshipJob < ApplicationJob
  queue_as :default

  def perform(relationship)
    RelationshipMailer.relationship_mail(relationship).deliver_now
  end
end
