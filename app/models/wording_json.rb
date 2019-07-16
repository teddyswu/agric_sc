class WordingJson < ActiveRecord::Base
	has_many :specify_ketwords, :as => :resource
end
