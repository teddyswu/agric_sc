class PostMessageApiJob < ActiveJob::Base
  queue_as :default
  
  def perform(*args)
    # Do something later
    
    # p self.job_id
  end
end
