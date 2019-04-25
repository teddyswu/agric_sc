class Track < CrowdDbConnecter
	self.table_name = "tracks"
  self.primary_key = "id"

  belongs_to :user
	belongs_to :campaign
end
