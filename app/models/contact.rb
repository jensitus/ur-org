class Contact < ApplicationRecord
  validates :name, length: { minimum: 2 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :message, presence: true

  after_create :do_the_job

  private

  def do_the_job
    puts 'self.inspect'
    puts self.inspect
    ContactMailJob.set(wait: 1.minute).perform_later(self)
  end

end
