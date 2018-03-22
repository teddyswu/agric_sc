class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_save :create_encryption
  has_many :user_datums

  def create_encryption
  	update_column(:encryption, Digest::SHA256.hexdigest(email))
  end
end
