class CampaignImage < CrowdDbConnecter
	self.table_name = "campaign_images"
  self.primary_key = "id"
  
  belongs_to :campaign
end