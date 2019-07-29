class AutoReply < ActiveRecord::Base
	has_one :auto_reply_rule
	has_one	:auto_reply_reply
	has_one :auto_reply_message
end
