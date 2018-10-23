class CampaignGroup < CrowdDbConnecter
	self.table_name = "campaign_groups"
  self.primary_key = "id"
  belongs_to :user
	belongs_to :campaign
end