class AutoReplyRule < ActiveRecord::Base
	belongs_to :auto_reply
	has_many :children, class_name: "AutoReplyRule", foreign_key: "parent_id"
end
