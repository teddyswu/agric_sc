class FavoFarmer < CrowdDbConnecter
	self.table_name = "favo_farmers"
  self.primary_key = "id"

	belongs_to :user
	belongs_to :farmer,  :class_name => "User", :foreign_key => "farmer_id"
end
