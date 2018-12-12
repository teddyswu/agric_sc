class Supporter < CrowdDbConnecter
	self.table_name = "supporters"
  self.primary_key = "id"
  belongs_to :order#, :class_name => "Order"
  
end