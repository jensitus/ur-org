module ReadPostObs
  extend ActiveSupport::Concern

  def after_create_read_post
    puts "AFTER CREATE READ POST"
    start_the_job(self)
  end

  def start_the_job(readpost)
    puts "START THE JOB"
    ReadPostJob.set(wait: 30.seconds).perform_later(readpost)
  end

end