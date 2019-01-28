class UserProfile < CrowdDbConnecter
	belongs_to :user

	self.table_name = "user_profiles"
  self.primary_key = "id"
end
