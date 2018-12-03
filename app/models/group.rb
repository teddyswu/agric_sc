class Group < ActiveRecord::Base
	has_many :message_push
	has_many :group_user_ships
end
