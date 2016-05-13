class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :tags, :dependent => :destroy
	has_many :reservations, :dependent => :destroy

	

	acts_as_taggable
	mount_uploaders :images, ImageUploader

end
