class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  after_create :logoutput

  private

  def logoutput
    puts 'messageModel'
    puts self.inspect
    puts self.class
  end

end
