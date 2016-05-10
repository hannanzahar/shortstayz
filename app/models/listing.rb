class Listing < ActiveRecord::Base
	belongs_to :user
	# attr_accessible :content, :name, :tag_list
	has_many :tags
	acts_as_taggable
end
