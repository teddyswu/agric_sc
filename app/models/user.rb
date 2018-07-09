class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  devise :registerable, :confirmable

  after_save :create_encryption
  has_many :user_datums
  has_many :user_farming_category_ships
  has_many :farming_categories, :through => :user_farming_category_ships
  has_one :user_profile, :foreign_key => "user_id"
  has_many :work_records, :foreign_key => "owner_id"
  has_many :work_record_reply
  has_many :authorizations

  extend OmniauthCallbacks


  def create_encryption
  	update_column(:encryption, Digest::SHA256.hexdigest(email))
  end
end
