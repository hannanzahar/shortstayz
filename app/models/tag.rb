require 'elasticsearch/model'

class Tag < ActiveRecord::Base
	belongs_to :listing

	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

end

Tag.import force: true