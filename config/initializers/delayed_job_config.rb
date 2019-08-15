silence_warnings do
  Delayed::Job.const_set("MAX_ATTEMPTS", 1)
end
Delayed::Worker.sleep_delay = 1