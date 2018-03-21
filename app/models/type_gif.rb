class TypeGif < ActiveRecord::Base
	mount_uploader :file, GifUploader
	#validates :file, presence: true
	
	has_many :digital_resource_ships
	accepts_nested_attributes_for :digital_resource_ships,    :allow_destroy => true
end
