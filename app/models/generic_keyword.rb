class GenericKeyword < ActiveRecord::Base
	has_one :generic_json, dependent: :destroy
end
