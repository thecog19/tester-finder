class Bug < ApplicationRecord
	validates :device_id, presence: true
	validates :user_id, presence: true
	validates :external_id, presence: true
end
