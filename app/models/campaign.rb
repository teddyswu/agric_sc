class Campaign < CrowdDbConnecter
	self.table_name = "campaigns"
  self.primary_key = "id"

  has_many :campaign_groups
  has_many :goodies, dependent: :destroy#, :class_name => "Goody"
  has_many :supporters, through: :goodies#, :class_name => "Supporter"
  has_many :orders, through: :goodies#, :class_name => "Order"
  has_one :campaign_image
  belongs_to :user


  def amount_raised
    goodies.inject(0) do |sum, g|
      sum += g.orders ? g.orders.is_paid.to_a.sum{ |p| p.amount + p.bonus.to_i }  : sum
    end
  end
end