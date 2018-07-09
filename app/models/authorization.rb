class Authorization < ActiveRecord::Base
	belongs_to :user#, :inverse_of => :authorizations # TODO 要研究一下 inverse_of
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider
end
