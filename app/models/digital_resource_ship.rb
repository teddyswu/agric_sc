class DigitalResourceShip < ActiveRecord::Base
	belongs_to :resource, :polymorphic => true

	after_save :create_encryption

  def create_encryption
  	update_column(:encryption, Digest::SHA256.hexdigest("id#{id.to_s}"))
  end
end
