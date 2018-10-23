class Goody < CrowdDbConnecter
	self.table_name = "goodies"
  self.primary_key = "id"

  belongs_to :campaign, -> { unscope(where: 'active') }
  has_many :orders
end