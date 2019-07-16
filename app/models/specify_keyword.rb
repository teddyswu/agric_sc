class SpecifyKeyword < ActiveRecord::Base
	has_one :specify_json, dependent: :destroy
	belongs_to :resource, polymorphic: true

	accepts_nested_attributes_for :specify_json
end
