class PostMessageApiJob < ActiveJob::Base
  queue_as :default
  
  def perform(*args)
    # Do something later
    
    # p self.job_id
    pp = MessagePush.find_by(:delayed_job_id => self.job_id)
    pp.complete_time = Time.now
    pp.save!
  end
end
