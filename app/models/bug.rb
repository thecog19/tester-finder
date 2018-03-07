class Bug < ApplicationRecord
	validates :device_id, presence: true
	validates :user_id, presence: true
	validates :external_id, presence: true

	def self.user_by_device(user_id, device_ids)
		Bug.where("user_id = ? AND device_id IN (?)", user_id, device_ids).count
	end
end
