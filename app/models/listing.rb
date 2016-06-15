require 'elasticsearch/model'

class Listing < ActiveRecord::Base
	# searchkick

	belongs_to :user
	has_many :tags, :dependent => :destroy
	has_many :reservations, :dependent => :destroy

	acts_as_taggable
	mount_uploaders :images, ImageUploader

	validates :name, presence: true
	validates :description, presence: true
	validates :country, presence: true
	validates :state, presence: true
	validates :city, presence: true
	validates :address, presence: true
	validates :property_type, presence: true
	validates :room_type, presence: true
	validates :num_people, presence: true
	validates :num_bedrooms, presence: true
	validates :num_beds, presence: true
	validates :num_bathrooms, presence: true
	validates :price, presence: true
	validates :images, presence: true

	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks
end

Listing.import force: true
#for auto sync model with elastic search