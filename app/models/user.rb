class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_save :create_encryption
  has_many :user_datums
  has_many :user_farming_category_ships
  has_many :farming_categories, :through => :user_farming_category_ships
  has_one :user_profile, :foreign_key => "user_id"
  has_many :work_records, :foreign_key => "owner_id"

  def create_encryption
  	update_column(:encryption, Digest::SHA256.hexdigest(email))
  end
end
