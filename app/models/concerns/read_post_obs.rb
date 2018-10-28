module ReadPostObs
  extend ActiveSupport::Concern

  def after_create_read_post
    start_the_job(self)
  end

  def start_the_job(readpost)
    logger.info "[ReadPostObs] start the job: #{readpost.inspect}"
    ReadPostJob.set(wait: 5.minutes).perform_later(readpost)
  end

end