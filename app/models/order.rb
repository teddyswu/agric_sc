class Order < CrowdDbConnecter
	self.table_name = "orders"
  self.primary_key = "id"

  belongs_to :goody
  belongs_to :user
  has_one :supporter, dependent: :destroy

  scope :is_paid, -> { where(paid: true) }
end